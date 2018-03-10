require './load_app'

# map classes to specific routes
Routes.call(self)

# setup telegram webhook dynamically
ApiRequester.new.make_request

# heroku specified logging
$stdout.sync = true
