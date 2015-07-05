module TreePrint
  def tree_to_s(*hosts)
    return '' if !hosts.any?
    height = hosts.compact.map(&:height).max
    buffer = indent(height)
    max_length = hosts.compact.map { |node| node.val.to_s.length }.max
    max_length = [8, max_length].min
    str = ""
    row = ""
    max_length.times do |i|
      row = hosts.inject("") do |sum, node|
        sum + buffer + node.val.to_s[i] + buffer + " " rescue sum + buffer + "." + buffer + " "
      end + " \n"
      str << row
    end
    if height > 1
      (2**(height-2)).times do
        row = row.gsub(/ \//, '/ ').gsub(/\\ /, " \\").gsub(/ [\w|.] /, '/ \\')
        str << row
      end
    end
    return str + tree_to_s(*hosts.flat_map{ |host|
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