module HashHelper
  def self.get_n_largest(hash, n)
    sorted_largest_elements = []

    if n > 0
      keys = hash.keys
      keys.each do |key|
        value = hash[key]
        length = sorted_largest_elements.length

        if length < n or hash[sorted_largest_elements[-1]] < value
          # Insert in sorted position
          last = [n - 1, sorted_largest_elements.length].min
          (0..last).each do |i|
            if length - 1 < i or hash[sorted_largest_elements[i]] < value
              sorted_largest_elements.insert(i, key)
              puts key
              break
            end
          end

          if sorted_largest_elements.length > n
            sorted_largest_elements.pop
          end
        end
      end
    end

    return sorted_largest_elements

    # return hash.keys[0, n]
    # return ["Hello", "world"]
  end
end