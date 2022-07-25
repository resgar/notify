# frozen_string_literal: true

require 'thor'
require 'notify'
require 'notify/connection'

module Notify
  class CLI < Thor
    desc "server --url URL", "Runs the server on a specific url"
    method_option :url, aliases: "-u"

    def start
      notifier = Notify::Monitor.new(interval: 5)
      conn = Notify::Connection.new(options[:url])

      notifier.watch do |message, time|
        puts '---------------------------'
        puts "New message at #{time}:\n\n"
        puts "Body: #{message}"
        puts "Response:"
        response = conn.post(message)
        if response[:error]
          puts 'Error - ' + response[:body]
        else
          puts response[:body] 
        end
      end

      if STDIN.tty?
        while (message = STDIN.gets) != "\n"
          notifier.push(message.chomp)
        end
      else
        $/ = "END"
        STDIN.gets.split("\n").each do |message|
          notifier.push(message)
        end
      end

      notifier.start
    end
  end
end