# Simple-Cache-Warmer

A Simple Cache Warmer Script for Linux based Systems.

Highlights
1. Meant for low resource servers. A lot of scripts out there pings ( bombards ) server with requests. This one does ONE url at a time. Putting a sleep / timeout between pings is error prone as the server might get overloaded.

2. Supports Sitemap and Sitemap Index files. Recursively traverses the sub sitemaps.

3. Outputs the result of URL pings in a log file ( Configurable ). Output consists of HTTP RESPONSE CODE, DATE and URL.

4. Can be configured as a cron job.

Requirements

1. Curl

2. Wget

Installation

1. Put the script file (cache_warmer.sh ) in a folder ( /etc )

2. Edit using vi or other editor :-
    - Change the log_file variable to point to your preferred log location. Defafults to "/var/log/cache_warmer.log"    
    - Change the domain and sitemap location parameters.
    
3. Grant execute permission to the script

  chmod +x cache_warmer.sh

4. To install as a cron job 
  - crontab -e
  - Make sure crontab has following lines
  
    SHELL=/bin/sh
    
    PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin
    
    Without this the script will fail to find the path for wget and curl.    
    
  - Add the following
    
    * * * * * /usr/bin/flock -n /tmp/cache_warmer.lock /etc/cache_warmer.sh
 
    (flock makes sure that we dont run two instances of the script. Required if we have lot of urls to process.)
    
 - Restart / Reload cron service
  
Once fired you may check the logs by doing tail -f /var/log/cache_warmer.log  

Sites Using Simple Cache Warmer

1. http://HighOnPoems.com
