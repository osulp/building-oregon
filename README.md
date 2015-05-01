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
