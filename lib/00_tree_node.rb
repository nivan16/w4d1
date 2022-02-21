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




