require "watir"
require "watir-webdriver/wait"
browser = Watir::Browser.new 
browser.goto "http://www.wordreference.com/"
puts browser.url


browser.select_list(:name => "dict").select_value("deen")



#browser.window(:url => "http://equitaliaonline.risconet.it/Risconet2/default.asp").use do
	#browser.refresh


#	browser.a(:text => "RUOLI").wait_until_present
#	browser.a(:text => "RUOLI").click
	#browser.goto "http://equitaliaonline.risconet.it/Risconet2/ruoli/ruoli.asp?mi=ruoli"
	#browser.a(:text => "RUOLI").click

#end
# browser.close