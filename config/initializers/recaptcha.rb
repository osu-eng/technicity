#./config/initializes/recaptcha.rb
# from github.com/ambethia/recaptcha README.rdoc
Recaptcha.configure do |config|
  config.public_key  = ENV["RECAPTCHA_PUBLIC"]
  config.private_key = ENV["RECAPTCHA_PRIVATE"]
end
