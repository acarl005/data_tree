require_relative 'node'
require_relative 'tree_print'
require 'pry'

class BinSearchTree

  include Enumerable, TreePrint
  attr_reader :head


  def initialize(head=nil)
    @head = head
  end

  def +(val)
    node = Node.new(val)
    if !@head
      @head = node
      return self
    end
    add_crawl(node)
    self
  end

  def -(val)
    parent, host = find_child_where(val)
    return self if host.nil?
    if host.num_children == 0
      if host < parent
        parent.left = nil
      else
        parent.right = nil
      end
    elsif host.num_children == 1
      if host < parent
        parent.left = host.left || host.right
      else
        parent.right = host.left || host.right
      end
    elsif !host.right.left
      parent.right = host.right
      parent.right.left = host.left
    else
      lm_child, lm_child_parent = host.right.leftmost_child
      lm_child_parent ||= host
      lm_child_parent.left = lm_child.right
      lm_child.right = host.right
      lm_child.left = host.left
      if host < parent
        parent.left = lm_child
      else
        parent.right = lm_child
      end
    end
    self
  end

  def find_child_where(val=nil)
    if block_given?
      each_node { |e|
        return [e, e.left] if e.left && yield(e.left.val)
        return [e, e.right] if e.right && yield(e.right.val)
      }
    else
      each_node { |e|
        return [e, e.left] if e.left && e.left == val
        return [e, e.right] if e.right && e.right == val
      }
    end
  end

  def add_crawl(node, host=@head)
    if node < host
      if !host.left
        return host.left = node
      else
        host = host.left
      end
    else
      if !host.right
        return host.right = node
      else
        host = host.right
      end
    end
    add_crawl(node, host)
  end

  def each(&block)
    return self if !@head
    visit(@head, block)
    self
  end

  def visit(host, block)
    return self if !host
    visit(host.left, block)
    block.call(host.val)
    visit(host.right, block)
  end

  def each_node(&block)
    return self if !@head
    visit_node(@head, block)
    self
  end

  def visit_node(host, block)
    return self if !host
    visit_node(host.left, block)
    block.call(host)
    visit_node(host.right, block)
  end

  def height
    return 0 if !@head
    @head.height
  end

  def right_height
    return 0 if !@head.right
    @head.right.height
  end

  def left_height
    return 0 if !@head.left
    @head.left.height
  end

  def unbalanced?
    return -1 if left_height - right_height > 1
    return 1 if right_height - left_height > 1
    false
  end

  def to_s
    tree_to_s(@head) if @head
  end

end

tree = BinSearchTree.new
tree + 4 + 2 + 3 + 2 + 1 + 1 + 6 + 5 + 5 + 4 + 4 + 15 + 18 + 21 + 7 + 8 + 9

puts tree

tree - 6 - 3

puts tree

p tree.map(&:to_s)
