# frozen_string_literal: true

# Maps main apps to proper routes
class Routes
  def self.call(rack)
    rack.map('/telegram') { run TelegramController }
    rack.map('/') { run WelcomeController }
  end
end
