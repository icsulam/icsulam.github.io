#!/usr/bin/perl

use WWW::Mechanize;
use LWP;
use LWP::Simple;
use utf8::all;
use DateTime;

#want: 12456 results

print "\n\n";
print "---------------------------\n";
print "  Obtaining prompt index  \n";
print "---------------------------\n";

$baseFolder = '/home/marvin/Desktop/Insight/WritingPrompts/';
$dataFolder = $baseFolder . 'PromptLevel2/';
#http://www.reddit.com/r/WritingPrompts/search.json?limit=100&sort=new&over18:%27no%27&title%3A[WP]&q=timestamp%3A1420070400..1420243200&restrict_sr=on&syntax=cloudsearch
#http://www.reddit.com/r/learnpython/search?sort=new&q=timestamp%3A1410739200..1411171200&restrict_sr=on&syntax=cloudsearch
$urlWP      = 'http://www.reddit.com/r/WritingPrompts/search.json?limit=100&over18:%27yes%27&&sort=new&title%3A[WP]&q=timestamp';

#first run with 15/16
#then 21/22
#Then 4/5
#then all days

for($thisYear  = 2013; $thisYear < 2016; $thisYear++)
{
for($today     = 1; $today     < 28; $today++)
{
$tomorrow = $today+1;
for($thisMonth = 1; $thisMonth < 13; $thisMonth++)
{
  #exit 2015 early
  if($thisYear == 2015)
  {
    if($thisMonth > 4)
    {
      next;
    }
  }
  my $dt_start = DateTime->new( year => $thisYear, month=>$thisMonth, day =>$today, hour => 1, minute=> 1, second=>0, nanosecond => 500000000, time_zone => 'Asia/Taipei' );
  my $dt_end   = DateTime->new( year => $thisYear, month=>$thisMonth, day =>$tomorrow, hour => 1, minute=> 1, second=>0, nanosecond => 500000000, time_zone => 'Asia/Taipei' );
  $point_start = $dt_start->epoch;
  $point_end   = $dt_end->epoch;
  $fullUrl     = $urlWP . '%3A' . $point_start . '..' . $point_end . '&restrict_sr=on&syntax=cloudsearch';
  print "$thisMonth -- " . $point_start . '--' . $point_end . "\n";

  ################################################################
  #information for account and key
  #theOutliers
  #dEBwTr0zIQewR0FoiTGYXb3wPRg
  ################################################################

  ################################################################
  # pull down the data
  $priorThread = '';
  for($i = 1; $i <= 10; $i++)
  {
      print "$i\n";
      #set file
      $indexFile = $dataFolder . $point_start . '_' . $i . '_nsfw.txt';

      #set url
      if($i == 1)
      {
          $myUrl = $fullUrl;
      } else {
          $startLoc = ($i - 1)*100;
          $myUrl    = $fullUrl . '&count=' . $startLoc . '&after=' . $priorThread;
      }

      ############################################
      # pull down data
      unless(-e $indexFile)
      {
          $initial_user_agent = "progressBot/1.0 by theOutliers";
          my $mech = WWW::Mechanize->new(agent => $initial_user_agent, autocheck => 0);

          $mech -> cookie_jar(HTTP::Cookies->new());
          #$myUrl = $url . $i;
          $res = $mech->get($myUrl);
          if($res->is_success()){

              open(FILEOUT, "> $indexFile");
              print FILEOUT $mech-> content();
              close FILEOUT;
              print "  ...found\n";
              sleep(5);
          }
      }

      ############################################
      # now read data to check
      $priorFound = 0;
      open(FILEIN, "< $indexFile");
      while($line = <FILEIN>)
      {
          if($line =~ /.*\"after\"\: \"(.*?)\", \"before\": .*?\}\}$/)
          {
             $priorThread = $1;
             $priorFound  = 1;
          }
      }
      close FILEIN;
      if($priorFound == 0)
      {
          print "no last thread found in $i\n";
          last;
      }
  }

} #thisMonth
} #today
} #thisYear
