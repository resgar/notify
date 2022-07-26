# frozen_string_literal: true

require 'thor'
require 'notify'
require 'notify/connection'
require 'notify/input'

module Notify
  class CLI < Thor
    desc "start", "Runs the server on a specific url"
    method_option :url, aliases: "-u", required: true
    method_option :interval, aliases: "-i", default: '5'

    def start
      notifier = Notify::Monitor.new(interval: options[:interval].to_i)

      input_handler = Notify::Input.get do |input|
        notifier.push(input)
      end

      notifier.watch do |messages, time|
        notifier.finish unless input_handler.status || messages.any?

        if messages.any?
          puts "******** New message at #{time}: ******** \n\n"
          conn = Notify::Connection.new(options[:url])
          messages.each do |message|
            puts "Message: #{message}"
            puts "Response:"
            response = conn.post(message)
            if response[:error]
              puts 'Error - ' + response[:body]
            else
              puts response[:body] 
            end
            puts '---------------------------'
          end
        end
      end
    end
  end
end