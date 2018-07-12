require 'nokogiri'
require 'open-uri'
require 'pry'

@my_hash = []
# méthode globale
def senator_informations
  listing_senator
end
# méthode pour récuperer le href de chaque député
def listing_senator
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  page.css('.col3 > li > a').each do |node|
    url_senator = node.values
    get_last_fist_name_email(url_senator)
  end
end
# methode pour recupere Nom,prénom et email
def get_last_fist_name_email(url_senator)
  email =[]
  name = []
  page2 = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr#{url_senator[0]}"))
  page2.xpath('//a[@class = "email"]').each do |node|
    h = node.values[1].delete_prefix('mailto:')
    email << h
  end
  #non et prénom
  name << page2.xpath('//h1').text
  #création du hash
  @my_hash = name.zip(email).to_h
  puts @my_hash

end

puts senator_informations
