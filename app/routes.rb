class Routes
  def self.call(rack)
    rack.map('/telegram'){ run TelegramApp }
    rack.map('/') { run Welcome }
  end
end
