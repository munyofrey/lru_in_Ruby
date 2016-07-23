require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key].nil?
      eject! if count == @max
      calc!(key)
    else
      update_link!(@map[key])
    end
    @map[key].val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)    # suggested helper method; insert an (un-cached) key
    @store.insert(key, @prc.call(key))
    @map.set(key, @store.last)
  end

  def update_link!(link)
    before = link.prev
    after = link.next

    before.next = after
    after.prev = before
    @store.last.next = link
    @store.sentinel_end.prev = link
    link.next = @store.sentinel_end
    link.prev = @store.last
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    @map.delete(@store.first.key)
    new_LRU = @store.first.next
    @store.sentinel_start.next = new_LRU
    new_LRU.prev = @store.sentinel_start
  end

end
