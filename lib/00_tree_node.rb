require "byebug"
class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @parent = nil
    @value = value
    @children = []
  end

  def parent=(node) 
    @parent.children.delete(self) if @parent != nil  #remove child from old parent
    
    @parent = node #now it changes the parent to the new one

    if parent != nil #only if there is a parent
      @parent.children << self if !@parent.children.include?(self) ## add the node to its new parent 
    end
  end

  def add_child(child) #this method just adds a new child to a node! 
    @children << child if !@children.include?(child)
    child.parent = self #the current node!
  end

  def remove_child(child) #this doesnt remove the child from the current node's children array!
    child.parent = nil
    raise "This is not a child of mine!" if !@children.include?(child)
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|

      found = child.dfs(target_value)
      return found if found != nil
      # found = child.dfs(target_value) if found.is_a?(PolyTreeNode) && child.dfs(target_value)
      # return found if found != nil
    end
    nil #returns nil on first stack if there is no target value found through all of the children!
  end

  def bfs(target_value)
    nodes = [self]
    until nodes.empty?
      c_node = nodes.shift
      if c_node.value == target_value
        return c_node
      else
        c_node.children.each {|child| nodes << child }
      end
    end

    return nil
  end

end

#######################################################################################################################
#######################################################################################################################

class KnightPathFinder

  attr_accessor :start_pos, :previous_moves, :new_moves
  
  def self.root_node





  end

  def self.valid_moves?(pos)
    idxs = (0..7).to_a
    row, col = pos
    return idxs.include?(row) && idxs.include?(col)
  end
  
  def initialize(starting_position) ##[0, 0]
    @start_pos = starting_position ## 
    @considered_positions = [@start_pos]
    @new_moves = []
  end

  def new_move_positions(pos) # [4,4]
    potential_moves=[]
    row, col = pos

    new_rows = [row + 2, row - 2]
    new_rows.each do |new_row|
        col_1 = col - 1
        col_2 = col + 1

        potential_moves << [new_row, col_1]
        potential_moves << [new_row, col_2]
    end

    new_cols = [col + 2, col - 2]
    new_cols.each do |new_col|
        row_1 = row - 1
        row_2 = row + 1
        
        potential_moves << [row_1, new_col]
        potential_moves << [row_2, new_col]
    end

     @new_moves = potential_moves.select do |a_move| #**************************** Note: need to change @start_pos to @current_pos(when we get to making @current_pos variable)!!!**********************
      c_move = []
      c_move << @start_pos[0] + a_move[0] #these two lines add the potential move from the current position to form the future position
      c_move << @start_pos[1] + a_move[1]         #ex: [0,0] is current pos, and a_move is [-2, 1] so      (0 + -2) is the row, and (0 + 1) is the column
      if KnightPathFinder.valid_moves?(a_move) && !@considered_positions.include?(a_move)
        c_move
      else

      end
    end
     return @new_moves
  end # end of new_move_positions method!!!!

  def build_move_tree

  end











end


