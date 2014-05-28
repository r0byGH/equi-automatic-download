require "watir-webdriver"
browser = Watir::Browser.new :ff
browser.goto "http://maps.google.it/"
puts browser.url
#browser.a(:text => "Google.com").click
#browser.a(:text => "Maps").click
puts browser.title
browser.a(:text => "Indicazioni stradali").click
browser.text_field(:title => "Indirizzo di partenza").set "Varazze"
browser.text_field(:title => "Indirizzo di arrivo").set "Torino"
browser.button(:name => "btnG").click
# browser.close