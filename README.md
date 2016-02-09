# bike-scrape
Scrape Craigslist for bikes, then email.

Use <code>crontab -e</code> to add the following line to check for bikes every 30 minutes:<br/>
<code>0,30 * * * * cd ~/bike && bash mail_control.sh</code>

Ruby code taken and changed from <a href="https://github.com/vikingeducation/scrape_demo">Viking Education</a>
