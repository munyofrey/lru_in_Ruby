class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0 if self.empty?
    hash_num = 0
    count = 0
    self.each do |el|
      if count.even?
        hash_num ^= el.hash
      else
        hash_num += el.hash
      end
      count += 1
    end
    Integer(hash_num)
  end
end

class String
  def hash
    self.codepoints.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    key_array = []
    keys.each do |key|
      key_array << key.hash
    end
    key_array.hash
  end
end
