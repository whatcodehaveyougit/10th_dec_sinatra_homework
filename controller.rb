require 'sinatra'
require 'sinatra/contrib/all'
# this line contrib.all is doing the refresh thing so we do
# have to keep re-running it every time.
require 'pry'
require_relative('./models/films')
require_relative('./models/customers')
also_reload('./models/*')
# If something in models changes then relaod it


get '/' do
  @films = Film.read_all()
  erb(:index)
end

get '/film_info/:id' do
  @film_info = Film.find_film_by_id(params[:id])
  erb(:film_info)
end


# MUST REQUIRE RELATIVE TO BRING IN A NEW CLASS
get '/customers' do
  @customers = Customer.read_all()
  erb(:customers)
end

# get '/find_info_batman' do
#  @film_info = Film.find_film_by_id(194)
#  erb[:film_info_batman]
# end
