APP_ENV = 'production'

map '/assets' do
  require 'sprockets'

  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/javascripts'
  environment.append_path 'app/assets/stylesheets'
  environment.append_path 'app/assets/fonts'
  environment.append_path 'app/assets/images'
  run environment
end

map '/' do
  require './app/bootstrap'
  require './config/api_credentials'
  require 'omniauth'
  require 'omniauth-google-oauth2'

  use Rack::Session::Cookie
  use OmniAuth::Builder do
    scope = 'https://www.googleapis.com/auth/userinfo.email '\
            'https://www.googleapis.com/auth/userinfo.profile'

    provider :google_oauth2,
             DeckApp::GAPI_CLIENT_ID,
             DeckApp::GAPI_CLIENT_SECRET,
             { :scope  => scope,
               :access => 'offline',
               :approval_prompt => '' }
  end

  run DeckApp::App.new
end
