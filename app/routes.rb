# frozen_string_literal: true

# Maps main apps to proper routes
class Routes
  def self.call(rack)
    rack.map('/telegram') { run TelegramApp }
    rack.map('/') { run Welcome }
  end
end
