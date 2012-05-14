require 'json'
require_relative '../app'

module DeckApp
  class App < Sinatra::Application

    # JSON-ified methods

    get '/api/decks/:id', :authenticates => true do
      deck = current_user.decks.first(:id => params[:id])

      deck.attributes.to_json
    end

    get '/api/decks', :authenticates => true do
      decks = current_user.decks.all.map do |deck|
        deck.attributes
      end

      decks.to_json
    end

    post '/api/decks', :authenticates => true do
     deck = current_user.create_deck(:name => json_params[:name])

      deck.attributes.to_json
    end

    # Single page methods

    get '/decks', :authenticates => true do
      decks = current_user.decks.all

      erb 'single_page', :locals => {:decks => decks}
    end

    get '/decks/new', :authenticates => true do
      erb 'single_page'
    end

    get '/decks/:id/edit', :authenticates => true do
      deck = current_user.decks.first(:id => params[:id])

      erb 'single_page', :locals => {:deck => deck}
    end

    # Old stuff - not yet api or single page

    post '/slides/:id', :authenticates => true  do
      slide = Slide.first(:id => params[:id])
      slide.content = params[:content]
      slide.save

      redirect to("/slides/#{slide.id}/edit")
    end

    post '/decks', :authenticates => true do
      current_user.create_deck(:name => params[:name])

      redirect to('decks')
    end

    get '/decks/:id/slides/new', :authenticates => true do
      deck = current_user.decks.first(:id => params[:id])

      erb 'slides/new', :locals => {:deck => deck}
    end

    post '/decks/:id/slides', :authenticates => true do
      deck = current_user.decks.first(:id => params[:id])
      slide = deck.create_slide(params[:content])

      redirect to("/decks/#{deck.id}/edit")
    end

    get '/slides/:id/edit', :authenticates => true do
      slide = Slide.first(:id => params[:id])
      deck  = slide.deck

      erb 'slides/edit', :locals => {:deck => deck, :slide => slide}
    end

    # ***************************
    #  Move, edit, delete slides
    # ***************************

    get '/decks/:deck_id/slides/:slide_id/move-left', :authenticates => true do
      deck  = current_user.decks.first(:id => params[:deck_id])
      slide = deck.slides.first(:id => params[:slide_id])

      deck.move_slide_left(slide)

      redirect to("/decks/#{deck.id}/edit")
    end

    get '/decks/:deck_id/slides/:slide_id/move-right', :authenticates => true do
      deck  = current_user.decks.first(:id => params[:deck_id])
      slide = deck.slides.first(:id => params[:slide_id])

      deck.move_slide_right(slide)

      redirect to("/decks/#{deck.id}/edit")
    end

    get '/decks/:deck_id/slides/:slide_id/delete', :authenticates => true do
      deck  = current_user.decks.first(:id => params[:deck_id])
      slide = deck.slides.first(:id => params[:slide_id])

      deck.delete_slide(slide)

      redirect to("/decks/#{deck.id}/edit")
    end

    get '/decks/:id' do
      deck  = Deck.first(:id => params[:id])

      redirect to("/decks/#{deck.id}/slides/#{deck.slides.first.id}")
    end

    get '/decks/:deck_id/slides/:number' do
      deck  = Deck.first(:id => params[:deck_id])
      slide = deck.slides.first(:number => params[:number])

      next_slide = deck.slides.first(:number => params[:number].to_i + 1)
      prev_slide = deck.slides.first(:number => params[:number].to_i - 1)

      erb 'decks/slideshow', :locals => {:deck => deck,
                                         :slide => slide,
                                         :next_slide => next_slide,
                                         :prev_slide => prev_slide},
                             :layout => false
    end

    # ****************************
    #       Unimplemented
    # ****************************

    post '/preview' do
      params[:content] # convert markdown to html
    end
  end
end
