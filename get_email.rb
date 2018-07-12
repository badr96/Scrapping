require 'rubygems'
require 'nokogiri' 
require 'open-uri'

url_racine = "http://annuaire-des-mairies.com/val-d-oise.html"
url_vaureal = "http://annuaire-des-mairies.com/95/vaureal.html"



def get_communes(url)
	
	communes = Array.new()
	pages = Nokogiri::HTML(open(url))   
	i = 1

		while i != pages.css('a.lientxt').length
			communes << pages.css('a.lientxt')[i]['href']
			i +=1
		end	
		return communes
end

def get_all_the_urls_of_val_doise_townhalls(url)

	mailing_list = Array.new()
	communes = get_communes(url)
	
	communes.each do |val|
	 
		 url_commune = "http://annuaire-des-mairies.com"+val
		 mailing_list << get_the_email_of_a_townhal_from_its_webpage(url_commune)
		
		 puts mailing_list
	end

	return mailing_list
end


def get_the_email_of_a_townhal_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	mail_vaureal =  page.css('td')[7].text

	return mail_vaureal
end


#puts get_the_email_of_a_townhal_from_its_webpage(url_vaureal) to get the adresse mail vaureal communes
mailing_list_communes = get_all_the_urls_of_val_doise_townhalls(url_racine)
puts mailing_list_communes
