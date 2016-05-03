# bike-scrape
Scrape Craigslist for bikes, then email.

## SMTP Setup
Must set up SMTP first. To set up for Gmail:  
```wget -qO- https://gist.githubusercontent.com/zvakanaka/6a0a23c611be1eccc15639ac3ed441d5/raw/42a97fdb2cdee75fdf6f671d0a91d3d6bc02ee30/gmail-smtp.sh | sudo bash```

## Crontab
Use `crontab -e` to add the following line to check for bikes every 30 minutes:  
`0,30 * * * * cd ~/bike-scrape && bash mail_control.sh`

Ruby code taken and changed from <a href="https://github.com/vikingeducation/scrape_demo">Viking Education</a>
