class String
  def indexes(needle)
    found = []
    current_index = -1
    while current_index = index(needle, current_index+1)
      found << current_index
    end
    found
  end
end

class TicTacToe
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip

  BOARD = <<BOARD
-------------
| X | X | X |
-------------
| X | X | X |
-------------
| X | X | X |
-------------
BOARD
  PLAYERS = ['X','O']

  attr_reader :position, :player

  def initialize
    @fields = Array.new(9).fill(' ')
    @position = 0
    @player = PLAYERS.first
  end

  def board
    index = -1
    BOARD.gsub(" X ") do
      index += 1
      field = @fields[index]
      @position == index ? "[#{field}]" : " #{field} "
    end
  end

  def move(x,y)
    x = (@position + x) % 3
    y = ((@position / 3) + y) % 3
    @position = x + (y * 3)
  end

  def set
    return if @fields[@position] != ' '
    @fields[@position] = @player
    switch_player
  end

  def winner
    [
      [0,1,2],[3,4,5],[6,7,8],  # vertical
      [0,3,6],[1,4,7],[2,5,8],  # horizontal
      [0,4,8],[2,4,6]           # diagonal
    ].each do |pattern|
      players = pattern.map{|i| @fields[i] }.uniq
      next if players.size != 1
      winner = players.first
      next if winner == ' '
      return winner
    end
    nil
  end

  private

  def switch_player
    current_player = PLAYERS.index(@player)
    next_player = (current_player + 1) % PLAYERS.size
    @player = PLAYERS[next_player]
  end
end