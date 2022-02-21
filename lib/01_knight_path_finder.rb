require_relative "./00_tree_node.rb"
require "byebug"
class KnightPathFinder

  attr_accessor :start_pos, :previous_moves, :new_moves, :root_node
  
  MOVES = [
        [2, -1],
        [2, 1],
        [-2, 1],
        [-2, -1],
        [-1, 2],
        [-1, -2],
        [1, 2],
        [1, -2],
    ]

    def self.valid_moves(pos) # [1, -2]
        # return all possible moves given any one position
        # debugger
        valid_moves = []
        x, y = pos
        MOVES.each do |(dx, dy)| # [2, 1]
            next_move = [x + dx, y + dy]

            if next_move.all? { |coord| coord.between?(0, 7) }
                valid_moves << next_move
            end
        end

        valid_moves
    end

  
  def initialize(start_pos) ##[0, 0]
    @start_pos = start_pos ## 
    @considered_positions = [@start_pos]
    build_move_tree
  end

  def new_move_positions(pos)
    potential_moves = KnightPathFinder.valid_moves(pos)

    potential_moves.select! do |move| # [[2, 4], [1, 3]...
      if !@considered_positions.include?(move) # modify this after new_move_positions built
        @considered_positions << move
        move
      end
    end

    potential_moves
  end


  def build_move_tree 
    self.root_node = PolyTreeNode.new(start_pos)
    line = [root_node]

    until line.empty?
      current_pos = line.shift
      current_value = current_pos.value 
      
      potential_moves = new_move_positions(current_value)

      potential_moves.each do |move|
        new_node = PolyTreeNode.new(move)
        current_pos.add_child(new_node)
        line << new_node
      end
    end
  end

  def find_path(end_pos)
    end_node = root_node.bfs(end_pos)
    trace_path_back(end_node)
  end
  
  def trace_path_back(node)
    return [node.value] if node.value == start_pos

    current_node = node
    paths = [current_node.value]
    current_parent = current_node.parent
    # paths << current_parent.value
    trace_path_back(current_parent) + paths 
    # paths << start_pos
    # paths
  end


 end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]

  # REVISIONS #################

  


# New_move_positions attempt 1 #########

# def new_move_positions(pos) # [4,4]
#     potential_moves=[]
#     row, col = pos

#     new_rows = [row + 2, row - 2]
#     new_rows.each do |new_row|
#         col_1 = col - 1
#         col_2 = col + 1

#         potential_moves << [new_row, col_1]
#         potential_moves << [new_row, col_2]
#     end

#     new_cols = [col + 2, col - 2]
#     new_cols.each do |new_col|
#         row_1 = row - 1
#         row_2 = row + 1
        
#         potential_moves << [row_1, new_col]
#         potential_moves << [row_2, new_col]
#     end

#      @new_moves = potential_moves.select do |a_move| #**************************** Note: need to change @start_pos to @current_pos(when we get to making @current_pos variable)!!!**********************
#       c_move = []
#       c_move << @start_pos[0] + a_move[0] #these two lines add the potential move from the current position to form the future position
#       c_move << @start_pos[1] + a_move[1]         #ex: [0,0] is current pos, and a_move is [-2, 1] so      (0 + -2) is the row, and (0 + 1) is the column
#       if KnightPathFinder.valid_moves?(a_move) && !@considered_positions.include?(a_move)
#         c_move
#       else

#       end
#     end
#      return @new_moves
#   end # end of new_move_positions method!!!!


# Self.valid_moves attempt 1 ###########

#   def self.valid_moves?(pos)
#     idxs = (0..7).to_a
#     row, col = pos
#     return idxs.include?(row) && idxs.include?(col)
#   end