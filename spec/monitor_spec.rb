# frozen_string_literal: true

RSpec.describe Notify::Monitor do
  describe "#watch" do
    it "returns new messages when queue updates" do
      notifier = Notify::Monitor.new(interval: 2)

      messages = ['Message one', 'Message two']
      messages.each { |m| notifier.push(m) }

      tracked_messages = []

      notifier.watch do |data, time|
        notifier.finish unless data.any?

        tracked_messages += data 
      end

      expect(tracked_messages).to eql(messages)
    end
  end
end
