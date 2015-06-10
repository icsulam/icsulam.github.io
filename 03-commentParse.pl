#!/usr/bin/perl

use WWW::Mechanize;
use LWP;
use LWP::Simple;
use utf8::all;
use DateTime;

print "\n\n";
print "---------------------------\n";
print "  Parsing comment data  \n";
print "---------------------------\n";

$baseFolder = '/home/marvin/Desktop/Insight/WritingPrompts/';
$dataFolder = $baseFolder . 'PromptLevel/';
$commFolder = $baseFolder . 'ResponseLevelJson/';
$promptCSV  = $baseFolder . 'PromptCSV/';
$commCSV    = $baseFolder . 'ResponseCSV/';

##################################
# now go through each prompt
#  make a hash of comments
##################################
$hashFile   = $baseFolder . 'hashComment.txt';
%commentHash= ();
open(FILEIN,  "< $hashFile");
while($line = <FILEIN>)
{
  #"1"," t3_1u59r5",0
  if($line =~ /^\"(\d*)\",\" t3_(.*?)\",(\d*)/)
  {
    $record = $2 . '.txt';
    $comment= $3;
    if(exists $commentHash{$record})
    {
      print "$record-$comment\n";
    }
    $commentHash{$record} = $comment;
  } else {
    print "$line\n";
  }
}

##################################
# now go through each prompt
#  convert JSON to CSV
##################################
opendir(DIR, $commFolder);
@fileList = grep(/\.txt/,readdir(DIR));
closedir(DIR);

#sleep(2);
$valid = $errors = 0;
for $file (@fileList)
{
  #$file = '1ubyy0.txt';
  $fileIn  = $commFolder . $file;
  $fileOut = $commCSV    . $file;
  
  unless(-e $fileOut)
  {
    #print "$commentHash{$file}\n";
    $comCnt = 0;
    open(FILEIN,  "< $fileIn");
    open(FILEOUT, "> $fileOut");
    print FILEOUT "file,id,gilded,archived,report,author,parent_id,score,approved,controversiality,body,edit,author,down,bodyHTML,subreddit,score_hidden,name,created,author_flair,created_utc,ups,mod_reports,num_reports,distinguished\n";
    while($line = <FILEIN>)
    {
      while($line =~ /^.*?false, "id": (.*?), "ups": (.*?)\}(.*)$/)
      {
        $thisEntry = 'id": ' . $1 . ', "ups": ' . $2 . ',';
        $line = $3;
        $comCnt++;
        $elementCount = 0;
        #print "$thisEntry\n";
        print FILEOUT "$file,";
        while($thisEntry =~ /^.*?": (.*?), "(.*)$/)
        {
          $element   = $1;
          $thisEntry = $2;
          $element =~ s/,//g;
          $element =~ s/'//g;
          $element =~ s/"//g;
          
          $element =~ s/&lt;//g;
          $elementCount++;
          print FILEOUT "$element,"
        }
        print FILEOUT "\n";
        #print "  $elementCount\n";
      }
    }
    close FILEIN;
  }
}
print "$valid -- $errors\n";
























