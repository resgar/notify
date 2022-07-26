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
        messages = []
        until queue.empty? do
          messages << queue.pop
        end
        yield messages, Time.now
      end
      start
    end

    def start
      thread.join
    end

    def finish
      thread.exit
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
