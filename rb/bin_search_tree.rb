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

  def to_s
    tree_print(@head) if @head
  end

end

tree = BinSearchTree.new
tree + 4 + 2 + 3 + 2 + 1 + 1 + 6 + 5 + 5 + 4 + 4 + 10 + 11 + 12

p tree.height
p tree.right_height
p tree.left_height

puts tree
