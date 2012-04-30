require_relative '../app'

module StarterApp
  class App < Sinatra::Application

    get '/decks', :authenticates => true do
      decks = current_user.decks
      erb 'decks/index', :locals => {:decks => decks}
    end

    get '/decks/new', :authenticates => true do
      erb 'decks/new'
    end

    post '/decks', :authenticates => true do
      current_user.new_deck(:name => params[:name])
      redirect to('decks')
    end

    post '/decks/:id/slides', :authenticates => true do

    end
  end
end
