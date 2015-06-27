require_relative 'node'
require 'pry'

class BinSearchTree

  include Enumerable
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

  def display
    repr(@head) if @head
  end

  def repr(*hosts)
    return '' if !hosts.any?
    height = hosts.compact.map(&:height).max
    buffer = indent(height)
    str = ""
    row = hosts.inject("") do |sum, node|
      sum + buffer + node.val.to_s + buffer + " " rescue sum + buffer + " " + buffer + " "
    end + " \n"
    str << row
    if height > 1
      (2**(height-2)).times do
        row = row.gsub(/ \//, '/ ').gsub(/\\ /, " \\").gsub(/ \d+ /, '/ \\')
        str << row
      end
    end
    return str + repr(*hosts.flat_map{ |host|
      if !host
        [nil, nil]
      else
        [host.left, host.right]
      end
    })
  end

  def indent(height)
    " " * (1...height).inject { |sum, n| sum + 2 ** (n-1) } rescue ""
  end

end

tree = BinSearchTree.new
tree + 4 + 2 + 3 + 2 + 1 + 1 + 6 + 5 + 5 + 4 + 4 + 10 + 11 + 12

p tree.height
p tree.right_height
p tree.left_height

puts tree.display


=begin
       1               4 7    1+2+4
      / \
     /   \
    /     \
   /       \
   1       1           3 3
  / \     / \
 /   \   /   \
 1   1   1   1         2 1
/ \ / \ / \ / \
1 1 1 1 1 1 1 1        1 0
=end
