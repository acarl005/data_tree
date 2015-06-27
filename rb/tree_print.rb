module TreePrint
	def tree_print(*hosts)
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
	  return str + tree_print(*hosts.flat_map{ |host|
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