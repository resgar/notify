# frozen_string_literal: true

module Notify
  class Input
    def self.get
      Thread.new do
        if STDIN.tty?
          while (input = STDIN.gets.to_s.chomp) != "exit"
            yield input
          end 
        else
          $/ = "END"
          STDIN.gets.split("\n").each do |input|
            yield input
          end
        end
      end
    end
  end
end
