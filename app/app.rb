require 'sinatra/base'
require 'padrino-helpers'
require 'sinatra/session'
require 'sinatra/flash'
require 'sass'

require_relative '../config/api_credentials'

module DeckApp

  class App < Sinatra::Application
    register Padrino::Helpers
    register Sinatra::Session

    enable :logging

    set :client_id,     DeckApp::GAPI_CLIENT_ID
    set :client_secret, DeckApp::GAPI_CLIENT_SECRET

    enable :static
    set    :root,           File.dirname(__FILE__)
    set    :assets,         File.dirname(__FILE__) + '/assets/'
    set    :public_folder,  settings.assets + '../public'

    helpers do
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

    def erb(file, *args)
      super(file.to_sym, *args)
    end
  end
end
