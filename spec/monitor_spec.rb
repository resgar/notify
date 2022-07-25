# frozen_string_literal: true

RSpec.describe Notify::Monitor do
  describe "#watch" do
    it "returns new messages when queue updated" do
      monitor = Notify::Monitor.new(interval: 2)

      new_messages = ['Message one', 'Message two']
      new_messages.each { |m| monitor.push(m) }

      tracked_messages = []

      monitor.watch do |message, time|
        tracked_messages << message 
      end

      expect(tracked_messages).to eql(new_messages)
    end
  end
end
