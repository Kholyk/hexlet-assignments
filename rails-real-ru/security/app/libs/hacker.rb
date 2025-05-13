# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'net/http'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      register_url = 'https://rails-collective-blog-ru.hexlet.app/users/sign_up'
      register_user_url = 'https://rails-collective-blog-ru.hexlet.app/users'

      uri = URI(register_url)
      register_user_uri = URI(register_user_url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      # GET register form
      request = Net::HTTP::Get.new(uri)

      response = http.request request
      cookie = response.response['set-cookie'].split('; ').first

      html = Nokogiri::HTML(response.body)
      authenticity_token = html.at('input[@name=authenticity_token]')['value']

      post_data = {
        'user[email]': email,
        'user[password]': password,
        'user[password_confirmation]': password,
        authenticity_token: authenticity_token
      }

      register_request = Net::HTTP::Post.new(register_user_uri)
      register_request.body = URI.encode_www_form(post_data)
      register_request['Cookie'] = cookie

      register_response = http.request register_request

      pp register_response.code
      pp '*' * 40
      pp register_response.body
      # debugger

      # END
    end
  end
end
