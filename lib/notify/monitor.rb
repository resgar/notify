# frozen_string_literal: true

module Notify
  class Monitor
    attr_reader :queue, :thread, :interval

    def initialize(interval: 5)
      @queue = Queue.new
      @interval = interval
    end

    def push(message)
      queue << message
    end

    def watch
      every(interval) do
        until queue.empty? do
          message = queue.pop
          yield message, Time.now
        end
      end
    end

    def start
      thread.join
    end

    private

    def every(n)
      @thread = Thread.new do
        loop do
          before = Time.now
          yield
          interval = n-(Time.now-before)
          sleep(interval) if interval > 0
        end
      end
    end
  end
end