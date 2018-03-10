require 'net/http'
require 'digest'
require 'cowsay'

class ApiRequester
  APP_URL = ENV['APP_URL'] || 'https://61a706c3.ngrok.io'
  API_TOKEN = ENV['API_TOKEN'] || '550551464:AAFlSdLD_drATesOuE_LHSzCKmNElf9AYDU'
  SECURE_STRING = Digest::SHA256.hexdigest(API_TOKEN)

  def make_request
    result = Net::HTTP.get(uri)
    puts Cowsay.say result, 'cow'
  end

  private

  def uri
    return @uri if !!@uri
    uri = URI("https://api.telegram.org/bot#{API_TOKEN}/setWebhook")
    params = {
      url: "#{ APP_URL }/telegram/webhook_#{ SECURE_STRING }"
    }
    uri.query = URI.encode_www_form(params)
    @uri = uri
  end
end
