require "watir"
require "watir-webdriver/wait"
require "watir-webdriver/extensions/alerts"
browser = Watir::Browser.new 
browser.goto "https://www.equitaliaservizi.it/was/autenticazione/login.jsp"
puts browser.url

# Effettua login
browser.text_field(:name => "username").set "E037482F"
browser.text_field(:name => "password").set "TUTTAGIOIA"
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
	browser.button(:text => "Prosegui").click

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
	
	browser.text_field(:name => "find_dtrivestart_show").set "01/12/2013"
	browser.text_field(:name => "find_dtriveend_show").set "31/01/2014"

	browser.button(:value => "CERCA RIVERSAMENTO").click
	
	puts "prima di wait"
	browser.link(:html => /#{Regexp.escape("setDownload(document.form_inedett[0])")}/).wait_until_present
	#browser.a(:onclick  => "setDownload(document.form_inedett[0]);return false ").wait_until_present
	puts "dopo wait"
	browser.link(:html => /#{Regexp.escape("setDownload(document.form_inedett[0])")}/).click
	#browser.a(:onclick  => "setDownload(document.form_inedett[0]);return false ").click
	puts "dopo click"

	browser.window(:title => "::: CONFERMA DOWNLOAD :::").wait_until_present
	browser.window(:title => "::: CONFERMA DOWNLOAD :::").use do
		browser.button(:value => "SCARICA").wait_until_present
		#browser.confirm(true) do
		browser.button(:value => "SCARICA").click
			
		wrauto = RAutomation::Window.new(:title => browser.title)
		wrauto.send_keys("{TAB}")
		wrauto.send_keys("{TAB}")
		wrauto.send_keys("{ENTER}")

		#browser.alert.ok
		#end
		#browser.wait(10)
		puts "dopo il wait"
		#browser.send_keys ("{TAB}")
		#browser.send_keys ("{TAB}")
		#browser.send_keys ("{ENTER}")
	end
	
end



#browser.window(:url => "http://equitaliaonline.risconet.it/Risconet2/default.asp").use do
	#browser.refresh


#	browser.a(:text => "RUOLI").wait_until_present
#	browser.a(:text => "RUOLI").click
	#browser.goto "http://equitaliaonline.risconet.it/Risconet2/ruoli/ruoli.asp?mi=ruoli"
	#browser.a(:text => "RUOLI").click

#end
# browser.close