# frozen_string_literal: true

require 'faraday'
require 'faraday/retry'

module Notify
  class Connection
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def post(message)
      result = connection.post do |req|
        req.body = {query: message}.to_json
      end

      {
        body: result.body
      }
    rescue Faraday::ConnectionFailed => e
      {
        error: true,
        body: 'connection failed'
      }
    end
  
    def connection
      @connection ||= Faraday.new(url) do |conn|
        conn.request(:retry, max: 2)
      end
    end
  end
end