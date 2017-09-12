#Building Oregon

Building Oregon is a mobile-centric web application which is intended for
discovery of architecture in the Pacific Northwest. 

#To install

```ruby
git clone https://github.com/osulp/building-oregon.git
```
One thing to double check is your ruby version. Make sure you are using Ruby
version `2.2.1`.
```ruby
cd building-oregon
bundle install
rake db:migrate
```
This application uses Jettywrapper from the samvera community.
```ruby
rake jetty:clean
rake jetty:config
```
If these commands dont work. Make sure jettywrapper is installed and then
prepend `bundle exec` to the commands.
```ruby 
bundle exec rake jetty:clean
bundle exec rake jetty:config
```
Then if you would like to load in the pre-existing data, run:
```ruby
rake data:mock
```
Then lastly,
```ruby
rails s
```

#Acknowedgements

![BrowserStack](/app/assets/images/browserstack-logo.jpg)

The development team uses <a href="http://browserstack.com" target="_blank">BrowserStack</a> for browser compatibility testing of <a href="http://buildingoregon.org" target="_blank">Building Oregon</a>
