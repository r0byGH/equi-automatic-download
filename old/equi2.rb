require "watir-webdriver"
require "watir-webdriver/wait"
browser = Watir::Browser.new :ff
browser.goto "https://equitaliaonline.risconet.it/canale.asp"
puts browser.url

# Effettua login
browser.text_field(:id => 'tbUserName').wait_until_present
browser.text_field(:name => "tbUserName").set "E037482F"
browser.text_field(:name => "tbPassword").set "TUTTAGIOIA"
browser.button(:name => "entra").click

puts browser.title
puts browser.url
#browser.a(:text => "RENDIWEB").click

# browser.close