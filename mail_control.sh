#!/bin/bash
# mail_control.sh by Adam Quinton
# Emails new Craigslist listings with a link to the item

# Crontab may not know which shell and path to use, so setting now
SHELL=/bin/bash
PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

email=("quintonish@gmail.com")
#adding item to email array
#email+=("strider5465@gmail.com" "cjgenteman91@gmail.com")
ITEM='Bike'
CURRFILE='listing.csv'
LASTFILE='last_listing.csv'
mv $CURRFILE $LASTFILE

ruby scrape.rb

#get number of lines with new items
NDIFF=$(diff $CURRFILE $LASTFILE | grep -c '<')

# If no find <, then no new items (csv hasn't changed) 
if [ $NDIFF -eq 0 ]; then
    echo Nothing new - $(date) >> log.txt
else
    echo $NDIFF new $ITEM items - $(date) >> log.txt
    #loop through emailees
    for i in "${email[@]}"; do
	echo -e 'To: '$i'\nFrom: '$i'\nSubject: '$NDIFF' New '$ITEM'(s) on Craigslist\n\n'$(diff $CURRFILE $LASTFILE | grep '<' | cut -d'<' -f 2)'\nTo be removed, reply STOP' > email.txt
    
# Replace commas with new lines
	sed 's/,/\n/g' < email.txt > fiddy_f2.txt

#Fix double URLs
	sed 's/http:\/\/eastidaho.craigslist.org\/\//http:\/\//g' < fiddy_f2.txt > fiddy_f3.txt
#	cp fiddy_f2.txt fiddy_f3.txt

# Add new lines after
	sed 's/html/html\n\n/g' < fiddy_f3.txt > email.txt
	rm fid*txt
	/usr/sbin/ssmtp $i < email.txt
    done
  #  rm email.txt
fi
