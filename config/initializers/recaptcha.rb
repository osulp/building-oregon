Recaptcha.configure do |config|
  config_file = YAML.load(ERB.new(File.read("#{Rails.root}/config/recaptcha.yml")).result)
  config.public_key  = config_file['recaptcha']['public_key'] || '6LetGR4TAAAAAPsDKUwnVJPLlJfNKWYmjruV8gPE'
  config.private_key = config_file['recaptcha']['private_key'] || '6LetGR4TAAAAADKju7q1OJaCc465e96ne9PfF8Pg'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end
