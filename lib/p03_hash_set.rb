require_relative 'p02_hashing'
require "byebug"
class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self[key].include?(key)
      resize! if count == num_buckets
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1 unless self[key].delete(key).nil?
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_mod = num_buckets * 2
    temp_array = Array.new(temp_mod, [])
    @store.each do |bucket|
      bucket.each do |num|
        temp_array[num.hash % temp_mod] << num
      end
    end
    @store = temp_array
  end
end
