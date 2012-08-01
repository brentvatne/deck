require 'json'
require_relative '../app'

module DeckApp
  class App < Sinatra::Application

    # API Methods
    get '/api/decks/:id' do
      deck = Deck.first(:id => params[:id])

      deck.attributes.to_json
    end

    get '/api/decks/:id/slides' do
     deck = Deck.first(:id => params[:id])

      slides = deck.slides.all.map do |slide|
        attributes = slide.attributes
        attributes[:content] = slide.content_as_html
        attributes
      end

      slides.to_json
    end

    get '/api/decks', :authenticates => true do
      decks = current_user.decks.all.reverse.map do |deck|
        deck.attributes
      end

      decks.to_json
    end

    post '/api/decks', :authenticates => true do
     deck = current_user.create_deck(:name => json_params[:name])

      deck.attributes.to_json
    end

    delete '/api/decks/:deck_id/slides/:slide_id', :authenticates => true do
      deck  = current_user.decks.first(:id => params[:deck_id])
      slide = deck.slides.first(:id => params[:slide_id])

      deck.delete_slide(slide)
    end

    post '/api/decks/:deck_id/slides/:slide_id/update-position', :authenticates => true do
      deck  = current_user.decks.first(:id => params[:deck_id])
      slide = deck.slides.first(:id => params[:slide_id])

      deck.update_slide_position(slide, params[:number].to_i)
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

    get '/decks/:id/slides/:slide_id/edit', :authenticates => true do
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

    # get '/decks/:deck_id/slides/:id/edit', :authenticates => true do
    #   deck  = current_user.decks.first(:id => params[:deck_id])
    #   slide = deck.slides.first(:id => params[:id])

    #   erb 'slides/edit', :locals => {:deck => deck, :slide => slide}
    # end

    # ***************************
    #  Move, edit, delete slides
    # ***************************

    get '/decks/:id' do
      deck  = Deck.first(:id => params[:id])

      redirect to("/decks/#{deck.id}/slides/1")
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
