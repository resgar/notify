# frozen_string_literal: true

require 'notify/input'

RSpec.describe Notify do
  it "has a version number" do
    expect(Notify::VERSION).not_to be nil
  end
end
