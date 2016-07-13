require 'bundler'
Bundler.require
require 'sidekiq/web'

module Sidekiq
  class Web
    set :session_secret, ENV['SECRET_KEY_BASE']

    before do
      authenticate! unless request.path_info == '/auth/auth0/callback'
    end

    use OmniAuth::Builder do
      provider :auth0, ENV['AUTH0_CLIENT_ID'], ENV['AUTH0_CLIENT_SECRET'], ENV['AUTH0_DOMAIN']
    end

    get '/auth/:name/callback' do
      session[:auth] = request.env['omniauth.auth']
      redirect to('/'), 302
    end

    get '/logout' do
      session[:auth] = nil
      redirect to("https://#{ENV['AUTH0_DOMAIN']}/v2/logout?returnTo=https://app.permitzone.com"), 302
    end

    private

    def authenticate!
      if session[:auth].nil?
        redirect to('/auth/auth0'), 302
      end

      unless session[:auth].dig('extra', 'raw_info', 'app_metadata', 'staff') == true
        halt 401, 'Not Authorized'
      end
    end
  end
end
