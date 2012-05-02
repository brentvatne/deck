module DeckApp
  class App < Sinatra::Application
    get '/' do
      if session[:uid]
        redirect to('/decks')
      else
        erb :home
      end
    end
  end
end
