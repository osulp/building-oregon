if Rails.env.development?
  require 'factory_girl'

  namespace :dev do
    desc 'Seed data for development environment'
    task prime: 'db:setup' do
      FactoryGirl.find_definitions
      include FactoryGirl::Syntax::Methods

    end
  end
end
