class Map
  def initialize(map = [[]])
    @map = map
  end
  def assign(key,value)
    replaced = false
    @map.each_with_index do |pair,index|
      if pair.first == key
        @map[index] = value
        replaced = true
        break
      end
    end
    @map << [key,value] if replaced == false
  end
  def lookup(key)
    @map.each_with_index do |pair,index|
      if pair.first == key
        @map.delete_at(index)
      end
    end
  end
  def show
    @map
  end
end
