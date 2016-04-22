Recaptcha.configure do |config|
  config_file = YAML.load(ERB.new(File.read("#{Rails.root}/config/recaptcha.yml")).result)
  config.public_key  = config_file['recaptcha']['public_key']
  config.private_key = config_file['recaptcha']['private_key']
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end
