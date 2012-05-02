require_relative '../app'

module DeckApp
  class App < Sinatra::Application

    get '/decks', :authenticates => true do
      decks = current_user.decks
      erb 'decks/index', :locals => {:decks => decks}
    end

    post '/decks', :authenticates => true do
      current_user.create_deck(:name => params[:name])
      redirect to('decks')
    end

    get '/decks/new', :authenticates => true do
      erb 'decks/new'
    end

    get '/decks/:id/edit', :authenticates => true do
      # check if it really belongs to this user
      deck = Deck.first(:id => params[:id])
      erb 'decks/edit', :locals => {:deck => deck}
    end

    get '/decks/:id/slides/new', :authenticates => true do
      deck = Deck.first(:id => params[:id])
      erb 'slides/new', :locals => {:deck => deck}
    end

    post '/decks/:id/slides', :authenticates => true do
      deck = Deck.first(:id => params[:id])
      deck.create_slide(params[:content])
      redirect to("/decks/#{params[:id]}/edit")
    end

    get '/slides/:id/edit' do
      slide = Slide.first(:id => params[:id])
      deck  = slide.deck
      erb 'slides/edit', :locals => {:deck => deck, :slide => slide}
    end

    post '/slides/:id' do
      slide = Slide.first(:id => params[:id])
      slide.content = params[:content]
      slide.save
      redirect to("/slides/#{slide.id}/edit")
    end

    post '/preview' do
      params[:content] # convert markdown to html
    end

    get '/decks/:id' do
      # actual slideshow here
    end
  end
end
