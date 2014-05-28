require "watir-webdriver"
require "watir-webdriver/wait"
require "watir-webdriver/extensions/alerts"
require 'fileutils'

load 'properties.rb'
p = load_properties("equi.properties")

data_start = p["data_start"]
data_end = p["data_end"]
search_folder = p["download_dir"]
search_folder += "/" + data_start.gsub("\/", "\-")  + "_" +  data_end.gsub("\/", "\-")  

Dir.mkdir(search_folder) unless Dir.exist?(search_folder)
FileUtils.rm Dir.glob(search_folder + "/" + "*.zip") #ripulisci cartella

prefs = {
	:download => {
	:prompt_for_download => false,
	:default_directory => search_folder
	}
}
	
#client = Selenium::WebDriver::Remote::Http::Default.new
#client.timeout = 180 # seconds – default is 60
 
browser = Watir::Browser.new :chrome, :prefs => prefs #, :http_client => client
#browser = Watir::Browser.new :chrome

browser.goto "https://www.equitaliaservizi.it/was/autenticazione/login.jsp"
puts browser.url

# Effettua login
browser.text_field(:name => "username").set p["username"]
browser.text_field(:name => "password").set p["password"]
browser.button(:name => "entra").wait_until_present
browser.button(:name => "entra").click


puts browser.title

browser.a(:text => "RENDIWEB").wait_until_present
browser.a(:text => "RENDIWEB").click

puts browser.title
puts browser.url
browser.window(:url => "https://www.equitaliaservizi.it/wass/autenticazione/home.do?service=RDW").use do
	puts "pippo"
	puts browser.url
	browser.button(:text => 'Prosegui').wait_until_present
	
	browser.confirm(true) do
		browser.button(:text => "Prosegui").click
	end


	#browser.wait(20)

	puts browser.title
	puts browser.url
	
	browser.a(:text => "RUOLI").wait_until_present
	browser.a(:text => "RUOLI").click
	
	browser.a(:text => "RIVERSAMENTI").wait_until_present
	browser.a(:text => "RIVERSAMENTI").click

	browser.a(:text => "RIVERSAMENTI", :index => 1).wait_until_present
	browser.a(:text => "RIVERSAMENTI", :index => 1).click
	
	browser.select_list(:name => "find_conce").select_value("")	
	
	browser.text_field(:name => "find_dtrivestart_show").set data_start
	browser.text_field(:name => "find_dtriveend_show").set data_end

	browser.button(:value => "CERCA RIVERSAMENTO").click
	
	puts browser.title
	puts browser.url

	browser.text_field(:name => "currPageText").wait_until_present
	currentPage = browser.text_field(:name => "currPageText").value
	myhtml = browser.text_field(:name => "currPageText").html
	puts currentPage
	puts myhtml
	myhtml.match(/this\.value\&gt;(\d+)\)\{alert/)
	nofpages = $1.to_i
	puts nofpages
	
	#nofpages = 3
	
	1.upto(nofpages) do
		|npage|
		puts npage
		
		currentPage = browser.text_field(:name => "currPageText").value.to_i
		if currentPage != npage
			#goto npage
			browser.text_field(:name => "currPageText").set "#{npage}"
			browser.button(:onclick => "document.form_nav.currPage.value=document.form_nav.currPageText.value;document.form_nav.submit()").click
			browser.div(:id => "footer").wait_until_present
		end
		
		filesinpage = 0
		0.upto(19) do
			|i|
			if browser.a(:onclick  => "setDownload(document.form_inedett[#{i}]);return false ").exists? 
				filesinpage = i + 1
			end
		end

		if Dir.exist?(search_folder + "/" + "pag#{npage}") then
			#se directory contiene tutti i files
			allfiles = true
			0.upto(filesinpage - 1) do
				|i|
				if i == 0 
					fname = search_folder + "/" + "pag#{npage}/" + "risconet.zip"
				else
					fname = search_folder + "/" + "pag#{npage}/" + "risconet (#{i}).zip"
				end
				if File.file?(fname) == false
					allfiles = false
				end
			end
			
			if allfiles then
				if npage == nofpages
					# TERMINATO CORRETTAMENTE
					puts "FINITO LO SCARICOOOOOOOOO!!!!!"
				end
				next
			else #pulisci cartella e continua
				FileUtils.rm Dir.glob(search_folder + "/" + "pag#{npage}/" + "*.zip")
			end
		end
		
		FileUtils.rm Dir.glob(search_folder + "/" + "*.zip") #ripulisci cartella di scarico
		#scarica i files
		0.upto(filesinpage - 1) do
			|i|
			if browser.a(:onclick  => "setDownload(document.form_inedett[#{i}]);return false ").exists? 
				puts "#{i}"
				#browser.a(:onclick  => "setDownload(document.form_inedett[#{i}]);return false ").wait_until_present #dovrebbe essere inutile ma..
				browser.a(:onclick  => "setDownload(document.form_inedett[#{i}]);return false ").click
		
				browser.window(:title => "::: CONFERMA DOWNLOAD :::").wait_until_present(180)
				browser.window(:title => "::: CONFERMA DOWNLOAD :::").use do
					browser.button(:value => "SCARICA").wait_until_present(180)
					browser.button(:value => "SCARICA").click
				end
			end

		end

		#wait until file completely downloaded: try wait 2 secs
		sleep(2)
		
		#salva dati pagina
		Dir.mkdir(search_folder + "/" + "pag#{npage}") unless Dir.exist?(search_folder + "/" + "pag#{npage}")
		FileUtils.mv Dir.glob(search_folder + "/" + "*.zip"), search_folder + "/" + "pag#{npage}"
		
		if npage < nofpages
			browser.text_field(:name => "currPageText").set "#{npage + 1}"
			browser.button(:onclick => "document.form_nav.currPage.value=document.form_nav.currPageText.value;document.form_nav.submit()").click
			browser.div(:id => "footer").wait_until_present
		elsif npage == nofpages
			# TERMINATO CORRETTAMENTE
			puts "FINITO LO SCARICOOOOOOOOO!!!!!"
		end

		
	end
end


#OPERAZIONI POST SCARICO
#uncompress di tutti i files

#crea unico file di testo




