require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'pry'

url_racine = "https://coinmarketcap.com/all/views/all/"

def get_name(url)
	page = Nokogiri::HTML(open(url))
	crypto_name = Array.new()

	page.css('a.currency-name-container.link-secondary').each do |val|
			crypto_name << val.text

	end
	return crypto_name
end


def get_price(url)
	page = Nokogiri::HTML(open(url))
	crypto_price = Array.new()

	page.css('a.price').each do |val|
			crypto_price << val.text

	end
	return crypto_price
end

##############MAIN##################

crypto = Hash.new

	crypto = {name:get_name(url_racine) ,price: get_price(url_racine)}
	
	crypto.each do|key,val|
		puts "#{key}: #{val} "
	end 