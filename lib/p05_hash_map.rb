require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val = nil)
    resize! if @count == num_buckets
    @count += 1 unless include?(key)
    bucket(key).insert(key, val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if include?(key)
    bucket(key).remove(key)
  end

  def each
  end



  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_mod = num_buckets * 2
    temp_array = Array.new(temp_mod) { LinkedList.new }
    @store.each do |list|
      list.each do |link|
        temp_array[link.key.hash % temp_mod].insert(link.key, link.val)
      end
    end
    @store = temp_array
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
