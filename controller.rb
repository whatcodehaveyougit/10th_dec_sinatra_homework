require 'sinatra'
require 'sinatra/contrib/all'
# this line contrib.all is doing the refresh thing so we do
# have to keep re-running it every time.
require 'pry'
require_relative('./models/films')
also_reload('./models/*')
# If something in models changes then relaod it



Film.all()
