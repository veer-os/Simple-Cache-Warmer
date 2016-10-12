#!/bin/bash

# Configuration
log_file="/var/log/cache_warmer.log"
domain="http://highonpoems\.com[^<]+"
sitemap_location="http://highonpoems.com/sitemap.xml"

# Mostly you will not have to edit below this line.
url_validator_regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

echo "Starting Cache Warmer" >> "$log_file"

sitemaps=( $(wget --quiet $sitemap_location --output-document - | egrep -o "$domain") )
for (( i=0; i<${#sitemaps[@]}; i++ ));
do
if [[ ${sitemaps[i]} =~ $url_validator_regex ]]
then   
	echo "Processing Sitemap - " ${sitemaps[i]}>> "$log_file";
	urls=( $(wget --quiet ${sitemaps[i]} --output-document - | egrep -o "$domain") )
	for (( j=0; j<${#urls[@]}; j++ ));
	do
		if [[  ${urls[j]} =~ $url_validator_regex ]]
		then
			   echo "Processing URL " ${urls[j]} >> "$log_file";
			   http_response_code=`curl -o /dev/null --silent --head --write-out '%{http_code}' ${urls[j]}`
			   date=$(date +"%d-%m-%y %r")
			   echo "[ ${http_response_code} - ${date} ] - ${urls[j]}" >> "$log_file"
	fi
	done
fi
done