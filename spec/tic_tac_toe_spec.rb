require File.expand_path('spec/spec_helper')

describe TicTacToe do
  def ttt; subject; end

  board_width = 14

  it "has a VERSION" do
    TicTacToe::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end

  describe 'on startup' do
    it "should draw an empty board on startup" do
      ttt.board.should_not include('X')
      ttt.board.should_not include('O')
      ttt.board.size.should == board_width * 7
    end

    it "should position the cursor in the first position" do
      ttt.board.indexes('[ ]').should == [board_width+1]
    end
  end

  describe :move do
    {
      [0,0] => 0,
      [1,0] => 1,
      [3,0] => 0,
      [-1,0] => 2,
      [0,1] => 3,
      [0,3] => 0,
      [0,-1] => 6,
    }.each do |move,position|
      it "is at position #{position} when moving from origin to #{move}" do
        ttt = TicTacToe.new
        ttt.move(*move)
        ttt.position.should == position
      end
    end

    it "updates the cursor" do
      ttt.move(1,1)
      ttt.board.index('[ ]').should == (board_width*3) + 5
    end
  end

  describe :set do
    it "marks the field for the current player" do
      ttt.set
      ttt.board.index('[X]').should == board_width + 1
    end

    it "switches the player" do
      ttt.player.should == 'X'
      ttt.set
      ttt.player.should == 'O'
      ttt.move(1,0)
      ttt.set
      ttt.player.should == 'X'
    end

    it "does not set an occupied field" do
      ttt.set
      ttt.set
      ttt.board.index('[O]').should == nil
    end

    it "does not switch players when setting an occupied field" do
      ttt.set
      ttt.set
      ttt.player.should == 'O'
    end
  end
end