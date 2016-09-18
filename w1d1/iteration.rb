class Array

  def my_each(&prc)
    for i in 0...self.length
      prc.call(self[i])
    end
  end
  def my_select(&prc)
    good = []
    self.my_each do |item|
      good << item if prc.call(item) == true
    end
    good
  end
  def my_reject(&prc)
    good = []
    self.my_each do |item|
      next if prc.call(item) == true
      good << item
    end
    good
  end
  def my_any?(&prc)
    self.my_each do |item|
      return true if prc.call(item) == true
    end
    return false
  end
  def my_all?(&prc)
    self.my_each do |item|
      return false if prc.call(item) == false
    end
    return true
  end
  def my_flatten
    flat = []
    self.my_each do |item|
      if item.class == Array
        flat += item.my_flatten
      else
        flat += [item]
      end
    end
    flat
  end
  def my_zip(*args)
    zipped = []
    for i in 0...self.length
      zipped << [self[i]] + args.collect{|row| row[i]}
    end
    zipped
  end
  def my_rotate(n=1)
    rotated = Array.new(self.length)
    n = n % self.length
    self.each.with_index do |item,index|
      rotated[index-n] = item
    end
    rotated
  end
  def my_join(seperator='')
    joined = ''
    self.my_each do |item|
      joined << item << seperator
    end
    joined
  end
  def my_reverse
    return self if self.length==1
    [self.last] + self[0...-1].my_reverse
  end
end
prc = Proc.new {|x| puts x}
array = [1,2,3,4]
array.my_each(&prc)
a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
