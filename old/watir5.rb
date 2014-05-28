require "watir-webdriver"
browser = Watir::Browser.new :ff
browser.goto "http://www.google.com/"
puts browser.url
browser.a(:text => "Google.com").click
browser.a(:text => "Images").click
puts browser.title
browser.text_field(:name => "q").set "book"
browser.button(:name => "btnG").click
puts browser.images.size
browser.close