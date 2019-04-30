require 'net/https'
require 'cgi'
require 'date'
require 'securerandom'
require 'openssl'
require 'base64'

module Twi
  # Twitter OAuth
  class OAuth
    CONSUMER_KEY = ENV['CONSUMER_KEY']
    CONSUMER_SECRET = ENV['CONSUMER_SECRET']

    def self.token(callback_url)
      url = 'https://api.twitter.com/oauth/request_token'
      params = {
        oauth_callback: callback_url,
        oauth_consumer_key: CONSUMER_KEY,
        oauth_signature_method: 'HMAC-SHA1',
        oauth_timestamp: Time.now.to_i.to_s,
        oauth_nonce: SecureRandom.hex,
        oauth_version: '1.0'
      }
      post_oauth(url, params)
    end

    def self.callback(oauth_token, oauth_token_secret, oauth_verifier)
      url = 'https://api.twitter.com/oauth/access_token'
      params = {
        oauth_token: oauth_token,
        oauth_verifier: oauth_verifier,
        oauth_consumer_key: CONSUMER_KEY,
        oauth_signature_method: 'HMAC-SHA1',
        oauth_timestamp: Time.now.to_i.to_s,
        oauth_nonce: SecureRandom.hex,
        oauth_version: '1.0'
      }
      post_oauth(url, params)
    end

    def self.post_oauth(url, params)
      params = params.map { |k, v| [k, CGI.escape(v)] }.to_h
      request_params = CGI.escape(params.map { |k, v| "#{k}=#{v}" }.sort.join('&'))
      sign_data = "POST&#{CGI.escape(url)}&#{request_params}"
      signature = Base64.encode64(OpenSSL::HMAC.digest('sha1', "#{CGI.escape(CONSUMER_SECRET)}&", sign_data))
      params['oauth_signature'] = CGI.escape(signature)

      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      req = Net::HTTP::Post.new(uri.request_uri)
      req['Authorization'] = "OAuth #{params.map { |k, v| "#{k}=#{v}" }.join(',')}"

      https.request(req).body.split('&').map { |v| [v.split('=')[0], v.split('=')[1]] }.to_h
    end
    private_class_method :post_oauth
  end
end
