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

      notifier.watch do |messages, time|
        if messages.any?
          Thread.new do
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

      input = nil

      if STDIN.tty?
        while (input = STDIN.gets.to_s.chomp) != "exit"
          notifier.push(input)
        end
      else
        $/ = "END"
        STDIN.gets.split("\n").each do |input|
          notifier.push(input)
        end
      end

      return if input == 'exit'

      notifier.start
    end
  end
end