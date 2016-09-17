require 'byebug'
def range(start_num,end_num)
  return nil if start_num > end_num
  return [start_num] if start_num == end_num
  [start_num] + range(start_num+1,end_num)
end


def sum(array)
  return array.first if array.length == 1
  array.first + sum(array[1..-1])
end

# array = [1,2,3]
# p sum(array)

def exp1(base,power)
  return 1 if power == 0
  base * exp1(base,power-1)
end

# p exp1(2,3)

def exp2(base, power)
  return 1 if power == 0
  if power.even?
    exp2(base, power / 2)*exp2(base,power / 2)
  else #power.odd?
    base * exp2(base,(power - 1)/2)*exp2(base,(power - 1) / 2)
  end
end

# p exp2(2,4)

class Array
  def dup
    copy = []
    self.each.with_index do |item,index|
      if item.class ==  Array
        copy << item.dup
      else
        copy << item
      end
    end
    copy
  end
end

# p [1, [2], [3, [4]]].dup

def sum(arr)
  total = 0
  arr.each {|i| total += i}
  total
end

def fibon(n)
  return [1,1] if n == 2
  return [1] if n == 1
  fibon(n-1) + [fibon(n-1)[-1]+fibon(n-1)[-2]]
end

# p fibon(5)

def bsearch(array,target)
  return nil if array.empty?
  middle = array.length/2

  if array[middle] == target
    return middle

  elsif array[middle] > target
    bsearch(array[0...middle],target)

  else #taget > array.middle
    l = bsearch(array[middle+1..-1],target)
    if l.nil?
      nil
    else
      l + middle + 1
    end
  end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil


def merge_sort(array)
  return [] if array.length == 0
  return [array.first] if array.length == 1

  middle = array.length / 2

  left = array.take(middle)
  right = array.drop(middle)

  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)

  merge(sorted_left, sorted_right)
end

def merge(left, right)
  sorted = []
  until left.empty? || right.empty?
    if left.first > right.first
      sorted << right.shift
    else # left > right and if left == right
      sorted << left.shift
    end
  end
  sorted + left + right
end

# array = [6,5,3,1,7,2,4]
# p merge_sort(array)

def subsets(array)
  return [[]] if array.empty?
  # previous_set = subsets(array[0..-2])
  # tack_on = previous_set.map{|chunk| chunk + [array.last]}
  # previous_set + tack_on

  # # for i in 0...array.length
  #   for j in i...array.length
  #     subs << array[i..j]
  #   end
  # end
  # subs
  # #
   chunks = subsets(array.take(array.count - 1))
   chunks + chunks.map { |chunk| chunk + [array.last] }
end

# p subsets([1,2,3])

def greedy_make_change(target, coins = [25, 10, 5, 1])
  return [target] if coins.include?(target)
  biggest_coin = [coins.select { |coin| coin if coin < target }.first]
  biggest_coin + greedy_make_change(target - biggest_coin.first)

end

def make_better_change(target, coins)
  return [target] if coins.include?(target)
  return [] if target == 0
  return nil if target < coins.min

  best_change = nil
  coins.each do |coin|
    next if coin > target
    remainder = target-coin
    current_change = make_better_change(remainder,coins)
    current_change = [coin] + current_change
    if best_change.nil? or (current_change.count < best_change.count)
      best_change = current_change
    end
  end
  best_change
end


# p greedy_make_change(99)
p make_better_change(24, [10, 7, 1])
