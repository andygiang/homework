class PolyTreeNode
  attr_accessor :value,:parent,:children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  def parent=(parent)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent
    parent.children << self unless parent.nil?
  end
  def add_child(child)
    unless @children.include?(child)
      child.parent = self
    end
  end
  def remove_child(child)
    raise "not my kid" unless @children.include?(child)
    child.parent = nil
    @children.delete(child)
  end
  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    return nil
  end
  def bfs(target_value)
    return self if @value == target_value
    q = [self]
    until q.empty?
      root = q.shift
      return root if root.value == target_value
      q += root.children
    end
    nil
  end
end
