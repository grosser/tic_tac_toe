require File.expand_path('spec/spec_helper')

describe TicTacToe do
  def ttt; subject; end

  def set_fields(a)
    ttt.instance_eval{@fields = a}
  end

  def get_fields
    ttt.instance_eval{@fields}
  end

  def board_full_without_winner
    set_fields ['O','X','O', 'O','X','O', 'X','O','X']
  end

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
      ttt.board.index('[ ]').should == board_width+1
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

  describe :winner do
    it "is nil when no-one has set" do
      ttt.winner.should == nil
    end

    it "is nil when no-one has won" do
      board_full_without_winner
      ttt.winner.should == nil
    end

    it "finds diagonal" do
      set_fields ['X','O',' ', ' ','X',' ', ' ','O','X']
      ttt.winner.should == 'X'
    end

    it "finds vertical" do
      set_fields ['X','O',' ', ' ','O',' ', ' ','O','X']
      ttt.winner.should == 'O'
    end

    it "finds horizontal" do
      set_fields ['X','O',' ', 'O','O','O', ' ','X','X']
      ttt.winner.should == 'O'
    end

    it "finds multiple" do
      set_fields ['O','O','O', 'X','O','X', ' ','X','O']
      ttt.winner.should == 'O'
    end
  end

  describe :ai do
    it "does not move if winner is selected" do
      set_fields(['O','O','O', ' ',' ',' ', ' ',' ',' '])
      ttt.ai_move
      ttt.player.should == 'X'
    end

    it "does not move if board is full" do
      board_full_without_winner
      ttt.ai_move
      ttt.player.should == 'X'
    end

    it "makes a move" do
      ttt.player.should == 'X'
      ttt.ai_move
      ttt.player.should == 'O'
    end

    it "prevents opponent from winning" do
      set_fields(['O','O',' ', ' ',' ',' ', ' ',' ',' '])
      ttt.ai_move
      get_fields.should == ['O','O','X', ' ',' ',' ', ' ',' ',' ']
    end

    it "tries to win" do
      set_fields(['O','O',' ', 'X','X',' ', ' ',' ',' '])
      ttt.ai_move
      get_fields.should == ['O','O',' ', 'X','X','X', ' ',' ',' ']
    end

    it "cannot prevent the inevitable" do
      set_fields(['O','O',' ', 'O','O',' ', ' ',' ',' '])
      ttt.ai_move
      get_fields.should == ['O','O','X', 'O','O',' ', ' ',' ',' ']
    end
  end
end