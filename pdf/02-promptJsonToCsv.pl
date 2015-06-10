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
$promptCSV  = $baseFolder . 'PromptCSV/';
$commCSV    = $baseFolder . 'ResponseCSV/';


##################################
# now go through each prompt
#  convert JSON to CSV
##################################
opendir(DIR, $dataFolder);
@fileList = grep(/\.txt/,readdir(DIR));
closedir(DIR);

for $file (@fileList)
{
  $fileIn   = $dataFolder . $file;
  $fileOut  = $promptCSV  . $file;
  $nsfwTags = 0;
  if($file =~ /_nsfw\.txt/)
  {
    $nsfwTags = 1;
  }
  $foundCount = 0;
  open(FILEOUT, "> $fileOut");
  print FILEOUT "domain,banned_by,media_embed,subreddit,selftext_html,selftext,likes,suggested_sort,user_reports,secure_media,link_flair_text,id,gilded,archived,clicked,report_reasons,author,media,score,approved_by,over_18,hidden,thumbnail,subreddit_id,edited,link_flair_css_class,author_flair_css_class,downs,mod_reports,secure_media_embed,saved,removal_reason,is_self,name,permalink,stickied,created,url,author_flair_text,title,created_utc,ups,num_comments,visited,num_reports, distinguished,nsfw\n";
  open(FILEIN,  "< $fileIn");
  while($line = <FILEIN>)
  {
    while($line =~ /{"kind": "t3", "data": (.*?)}},(.*)/)
    {
      $thisThread = $1;
      $line       = $2;
      $foundCount++;
      $pairCount = 0;
      $archThread = $thisThread;
      while($thisThread =~ /^(.*?):(.*?), "(.*)$/)
      {
        $key   = $1;
        $value = $2;
        $thisThread = $3;
        $value =~ s/,//g;
        $value =~ s/\'//g;
        $value =~ s/\"//g;
        print FILEOUT "$value,";
        $pairCount++;
      }
      if($pairCount != 45){
      print "$pairCount\n";
      print "$archThread\n";
      }
      print FILEOUT "$nsfwTags\n";
    }
  }
  close FILEIN;
  close FILEOUT;
  
  print "$file -- $foundCount\n";
  
}

