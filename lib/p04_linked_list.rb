require 'byebug'

class Link

  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @sentinel_start = Link.new
    @sentinel_end = Link.new
    @sentinel_start.next = @sentinel_end
    @sentinel_end.prev = @sentinel_start
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel_start.next
  end

  def last
    @sentinel_end.prev
  end

  def empty?
    @sentinel_end.prev == @sentinel_start
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
  end

  def include?(key)
    return true unless get(key).nil?
    false
  end

  def insert(key, val = nil )

    self.each do |link|
      if link.key == key
        link.val = val
      end
    end
    new_link = Link.new(key, val)
    last = self.last
    new_link.prev = last
    new_link.next = @sentinel_end
    last.next = new_link
    @sentinel_end.prev = new_link
  end

  def remove(key)
    self.each do |link|
       if link.key == key
         prev_link = link.prev
         next_link = link.next
         prev_link.next = next_link
         next_link.prev = prev_link
         return
       end
    end
  end

  def each
    link = self.first
    until link == @sentinel_end
      yield(link)
      link = link.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
