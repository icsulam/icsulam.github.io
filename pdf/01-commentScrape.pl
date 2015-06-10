#!/usr/bin/perl

use WWW::Mechanize;
use LWP;
use LWP::Simple;
use utf8::all;
use DateTime;

#want: 12456 results

print "\n\n";
print "---------------------------\n";
print "  Obtaining comment list  \n";
print "---------------------------\n";

$baseFolder = '/home/marvin/Desktop/Insight/WritingPrompts/';
$dataFolder = $baseFolder . 'PromptLevel/';
$commFolder = $baseFolder . 'ResponseLevelJson/';

##################################
# now go through each prompt
#  pull down the comments
##################################
opendir(DIR, $dataFolder);
@fileList = grep(/_nsfw\.txt/,readdir(DIR));
closedir(DIR);

foreach $file (@fileList)
{

  $fileIn = $dataFolder . $file;

  open(FILEIN, "< $fileIn");
  while($line = <FILEIN>)
  {
    while($line =~ /"permalink": "(.*?)", "stickied(.*)/)
    {
      $urlToGet = 'http://www.reddit.com' . $1 . '.json';
      $line     = $2;
      
      #print "$urlToGet\n";
      if($urlToGet =~ /comments\/(.*?)\//)
      {
        $commentNo  = $1;
        $fileToSave = $commFolder . $commentNo . '.txt';
        
        ############################################
        # pull down data
        unless(-e $fileToSave)
        {
            $initial_user_agent = "progressBot/1.0 by theOutliers";
            my $mech = WWW::Mechanize->new(agent => $initial_user_agent, autocheck => 0);

            $mech -> cookie_jar(HTTP::Cookies->new());
            $res = $mech->get($urlToGet);
            if($res->is_success()){

                open(FILEOUT, "> $fileToSave");
                print FILEOUT $mech-> content();
                close FILEOUT;
                print "  ...found\n";
                sleep(3);
            }
        }
        
      }
    }
  }
  close FILEIN;
}
