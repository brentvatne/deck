require 'sinatra/base'
require 'padrino-helpers'
require 'sinatra/flash'
require 'sass'
require 'coffee-script'
require_relative '../config/api_credentials'

module DeckApp

  # This portion of the app handles Sinatra configuration and asset serving.
  class App < Sinatra::Application
    register Padrino::Helpers

    enable :sessions
    enable :logging

    set :client_id,     DeckApp::GAPI_CLIENT_ID
    set :client_secret, DeckApp::GAPI_CLIENT_SECRET

    enable :static
    set :root,           File.dirname(__FILE__)
    set :dynamic_assets, File.dirname(__FILE__) + '/assets/dynamic'
    set :static_assets,  File.dirname(__FILE__) + '/assets/static'
    set :public_folder,  settings.static_assets
    set :scss_dir,       '/assets/dynamic/stylesheets'
    set :coffee_dir,     '/assets/dynamic/coffeescripts'
    set :template_dir,   settings.dynamic_assets + '/coffeescripts/templates'

    # Both of these get requests are not even called if matching files are found
    # in the static assets directory
    get '/stylesheets/*.css' do
      scss_file = params[:splat].first
      if stylesheet_exists?(scss_file)
        scss :"../#{settings.scss_dir}/#{scss_file}"
      else
        halt 404
      end
    end

    get '/javascripts/*.js' do
      coffee_file = params[:splat].first
      if coffeescript_exists?(coffee_file)
        coffee :"../#{settings.coffee_dir}/#{coffee_file}"
      else
        halt 404
      end
    end

    helpers do
      def template(relative_path)
        template_file = File.join(settings.template_dir, relative_path + ".html")
        if File.exists?(template_file) then File.read(template_file) else "" end
      end

      def json_params
        @json_params ||= JSONParamsWrapper.new(request.body)
      end

      class JSONParamsWrapper
        def initialize(body)
          @parsed_request_body = JSON.parse(body.read)
        end

        def [](key)
          @parsed_request_body[key.to_s]
        end
      end
    end

    private

    # Checks the disk to see if the given filename exists as a scss spreadsheet
    #
    # Returns true if it does exist, false if not
    def stylesheet_exists?(asset)
      File.exists?(File.join(settings.root, settings.scss_dir, asset + ".scss"))
    end

    # Checks the disk to see if the given filename exists as coffeescript
    #
    # Returns true if it does exist, false if not
    def coffeescript_exists?(asset)
      File.exists?(File.join(settings.root, settings.coffee_dir, asset + ".coffee"))
    end

    def erb(file, *args)
      super(file.to_sym, *args)
    end
  end
end
