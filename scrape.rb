require 'rubygems'
require 'mechanize'
require 'csv'
# Include this next line for debugging, must also enable line at bottom
# require 'pry-byebug'

# Craigslist scraper
# Initial code from http://www.vikingcodeschool.com/posts/web-scraping-craigslist-with-rubys-mechanize-gem

scraper = Mechanize.new
scraper.history_added = Proc.new { sleep 0.5 }

BASE_URL = 'http://eastidaho.craigslist.org'
ADDRESS = 'http://eastidaho.craigslist.org/search/bik'
search_term = 'Rexburg'
unwanted = [ 'women', 'woman', 'kid', 'girl' ]
top_price = 200
bottom_price = 1
results = []

scraper.get(ADDRESS) do |search_page|
  search_form = search_page.form_with(:id => 'searchform') do |search|
    search.query = search_term
    search.min_price = bottom_price
    search.max_price = top_price
  end

#get the whole page
results_page = search_form.submit

# get the results
raw_results = results_page.search('p.row')

#parse the results
raw_results.each do |result|
  link = result.css('a')[1]
   
  name = link.text.strip

  #properly get link
    url = BASE_URL + link.attributes["href"].value
  
  price = result.search('span.price').text
  #remove double price
  price = price.sub(/\$[0-9]+/, '')
  #if there was only one $, do it again
  if !price.include?('$')
    price = result.search('span.price').text
  end
  
  location = result.search('span.pnr').text[3..-13]
  #save the results if desired
#3UPPER
capital_count =  name.scan(/[A-Z]/).length

name_array = []
name_array.push(name.downcase)

  if !unwanted.any? { |word| name.downcase.include?(word) } && capital_count < 9
     results << [name, price, location, url]
  end
end

# This is the line at bottom for debugging
# binding.pry

CSV.open("listing.csv", "w+") do |csv_file|
  results.each do |row|
    csv_file << row
  end
end

end
