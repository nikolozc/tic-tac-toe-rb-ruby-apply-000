def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index , current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |element|
    if(element == "X" || element == "O")
      counter+=1
    end
  end
  return counter
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end


WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],
[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    win_index1 = combination[0]
    win_index2 = combination[1]
    win_index3 = combination[2]
    
    position1 = board[win_index1]
    position2 = board[win_index2]
    position3 = board[win_index3]
    
    if (position1 == "X" && position2 == "X" && position3 == "X")
      return combination
    elsif (position1 == "O" && position2 == "O" && position3 == "O")
      return combination
    end
  end
  return false
end

def full?(board)
  board.each_index do |index|
    if(!position_taken?(board,index))
      return false
    end
  end
  return true
end

def draw?(board)
  if(full?(board) && !won?(board))
    return true
  else
    return false
  end
end

def over?(board)
  if(full?(board) || draw?(board) || won?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if(!won?(board))
    return nil
  end
  return board[won?(board)[0]]
end

def play(board)
  while(!over?(board)) do
    turn(board)
  end
  if(draw?(board))
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end