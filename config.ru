require './app/app'

map '/telegram' do
  run TelegramApp
end

run App
