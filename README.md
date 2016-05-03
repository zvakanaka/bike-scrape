# bike-scrape
Scrape Craigslist for bikes, then email.


Use <code>crontab -e</code> to add the following line to check for bikes every 30 minutes:<br/>
<code>0,30 * * * * cd ~/bike-scrape && bash mail_control.sh</code>

Must set up SMTP first. To set up for Gmail: `wget -q0- https://gist.githubusercontent.com/zvakanaka/6a0a23c611be1eccc15639ac3ed441d5/raw/42a97fdb2cdee75fdf6f671d0a91d3d6bc02ee30/gmail-smtp.sh | sudo bash`

Ruby code taken and changed from <a href="https://github.com/vikingeducation/scrape_demo">Viking Education</a>
