class Node

  include Comparable
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = nil
    @right = nil
  end

  def height(host=self)
    return 0 if !host
    1 + [height(host.left), height(host.right)].max
  end

  def <=>(node)
    val <=> node.val
  end

  def to_s
    val.to_s
  end

  def num_children
    (left ? 1 : 0) + (right ? 1 : 0)
  end

  def leftmost_child
    host = self
    parent = nil
    until !host.left
      parent = host
      host = host.left
    end
    [host, parent]
  end

end
