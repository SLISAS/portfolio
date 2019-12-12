require "factory_bot_rails"
Dir[Rails.root.join("spec", "support", "**", "*.rb")].each { |f| require f }

FactoryBot.create_list(:user, 90)
