module DeckApp
  class App < Sinatra::Application
    get '/' do
      session[:uid] = nil
      erb :home
    end
  end
end
