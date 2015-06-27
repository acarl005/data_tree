class Node

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

	def ==(node)
		val == node
	end

	def <=>(node)
		val <=> node.val
	end

	def <(node)
		val < node.val
	end

	def >(node)
		val > node.val
	end

	def <=(node)
		val <= node.val
	end

	def >=(node)
		val >= node.val
	end

end