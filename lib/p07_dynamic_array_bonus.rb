class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i < 0
      return nil if abs(i) > capacity
      capacity.times do |j|
        if self[j].nil?
          return self[j + i]
        end
      end
    else
      @store[i]
    end

    rescue
      return nil
  end

  def []=(i, val)
    @store[i] = val
    rescue
      return nil
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each {|el| return true if el == val }
    false
  end

  def push(val)
    resize! if count == capacity

    capacity.times do |i|
      if self[i].nil?
        self[i] = val
        @count += 1
        break
      end
    end
  end

  def unshift(val)
    resize! if count == capacity
    tmp_array = StaticArray.new(capacity)
    tmp_array[0] = val
    (capacity - 1).times do |i|
      tmp_array[i + 1] = self[i]
    end
    @store = tmp_array
  end

  def pop
    return nil if self[0] == nil
    capacity.times do |i|
      if self[i].nil?
        var = self[i - 1]
        self[i - 1] = nil
        @count -= 1
        return var
      end
    end
    var = self[-1]
    self[-1] = nil
    @count -= 1
    var
  end

  def shift
    var = self[0]
    return nil if var == nil
    temp_array = StaticArray.new(capacity)
    (capacity - 1).times do |i|
      temp_array[i] = self[i + 1]
    end
    @count -= 1
    @store = temp_array
    var
  end

  def first
    self[0]
  end

  def last
    capacity.times do |i|
      return self[i - 1] if self[i].nil?
    end
  end

  def each
    i = 0
    while i < capacity
      yield(self[i])
      i += 1
    end
    @store
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    capacity.times do |i|
      return false if self[i] != other[i]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    tmp_capacity = capacity * 2
    tmp_array = StaticArray.new(tmp_capacity)
    capacity.times do |i|
      tmp_array[i] = self[i]
    end
    @store = tmp_array
  end
end
