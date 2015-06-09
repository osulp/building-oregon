#Building Oregon

Building Oregon is a mobile-centric web application which is intended for
discovery of architecture in the Pacific Northwest. 

#To install

```ruby
git clone https://github.com/osulp/building-oregon.git
cd building-oregon
bundle install
rake db:migrate
rake jetty:clean
rake jetty:config
rails s
```

#Acknowedgements

![BrowserStack](/app/assets/images/browserstack-logo.jpg)

The development team uses <a href="http://browserstack.com" target="_blank">BrowserStack</a> for browser compatibility testing of <a href="http://buildingoregon.org" target="_blank">Building Oregon</a>