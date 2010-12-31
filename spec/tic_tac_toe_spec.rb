require File.expand_path('spec/spec_helper')

describe TicTacToe do
  it "has a VERSION" do
    TicTacToe::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end
end
