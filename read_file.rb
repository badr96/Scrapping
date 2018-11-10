require 'nokogiri'
require 'open-uri'
require 'json'

def read_file(file)
	data = Array.new
	f =File.open(file, "r")
	f.each_with_index do |line, i|
		data << line
	end
	return data
end


def parsefile()
  data = read_file'URL.txt'
	clean_data = Array.new
  title = ''
  for_how_many = ''
  time = ''
  aliments = Array.new
  qt = Array.new
  preparation = Array.new
	categorie = Array.new
	recettes = []

		data.each do |val|
			clean_data << val.gsub(/[ \t\r\n\f]/i, '')
		end

		clean_data.first(5).each do |val|
	    page = Nokogiri::HTML(open(val))

	    title = page.css('h1.main-title').text

	    for_how_many = page.css('span.title-2.recipe-infos__quantity__value').text

	    time = page.css('span.title-2.recipe-infos__total-time__value').text

	    page.css('span.ingredient').each do|val|
	      aliments << val.text
	    end

	    page.css('span.recipe-ingredient-qt').each do |val|
	      qt << val.text.to_f.round(2)
	    end

	    page.css('li.recipe-preparation__list__item').each do |val|

				preparation << val.text.gsub(/[^a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]/i, '')
			 end

		 	page.css('a.mrtn-tag--grey').each do |val|
				categorie << val.text.gsub(/[^a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]/i, '')
			end

			recettes.push({title: title,for_how_many: for_how_many,time: time,qt: qt, aliments: aliments, preparation: preparation, categorie: categorie})

			file = File.open("recettes.js", "a+")
				file.write("db.recettes.insert("+recettes.to_json+");")
				recettes.clear
				file.close
		end

end


########MAIN############
parsefile
