require 'selenium-webdriver'
require 'watir-webdriver'
require 'bench'
 
d = Selenium::WebDriver.for :chrome, native_events: true
b = Watir::Browser.new d
b.goto 'bing.com'
 
benchmark 'set chrome native' do
  b.text_field(name: 'q').set 'ghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghghgh'
end
 
run 10
b.close