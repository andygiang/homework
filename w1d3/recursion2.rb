def range(start,num)
	return [start] if start == num
	[start] + range(start+1,num)
end

p range(1,3)

def sum(array)
	return array.first if array.length == 1
	array.first + sum(array[1..-1])
end

p sum([1,2,3])

def exp1(base,power)
	return 1 if power == 0
	base * exp1(base, power - 1)
end

p exp1(2,3)

def exp2(base,power)
	return 1 if power == 0
	if power.even?
		base * exp2(base, power / 2)* exp2(base, power / 2)
	else
		base * exp2(base, (power - 1) / 2)*exp2(base, (power - 1) / 2)
	end
end

p exp2(2,3)

def dup(array)
	 duplicate = []
	array.each do |item|
		if item.is_a?(Array)
			duplicate << dup(item)
		else
			duplicate << item
		end
	end
	duplicate
end

p dup([1,[2,7],3])

def fibon(n)
  return [1] if n==1
  return [1,1] if n==2
  fibon(n-1) << fibon(n-1)[-1] + fibon(n-1)[-2]
end

p fibon(5)

def bsearch(array,target)
  return nil if array.empty?
  middle = array.length/2
  bottom = array[0...middle]
  top = array[middle+1..-1]
  if target == array[middle]
    return middle
  elsif target < array[middle] #search bottom half
    bsearch(bottom,target)
  else
    offset = bsearch(top,target)
    if offset.nil?
      return nil
    else
      offset + middle + 1
    end
  end
end

p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def merge(top,bottom)
  sorted = []
  until top.empty? or bottom.empty?
    if top.first < bottom.first
      sorted << top.shift
    else
      sorted << bottom.shift
    end
  end
  (sorted + top + bottom).flatten
end
def merge_sort(array)
  return [] if array.empty?
  return array if array.length == 1
  middle = array.length/2
  bottom = array[0...middle]
  top = array[middle..-1]
  sorted_top,sorted_bottom = merge_sort(top),merge_sort(bottom)
  merge(sorted_top,sorted_bottom)
end

p merge_sort([1,2,3,4,5].shuffle)

def subsets(array)
  return [[]] if array.empty?
  previous_set = subsets(array[0..-2])
  tack_on = previous_set.map {|chunk| chunk + [array.last]}
  previous_set + tack_on
end

p subsets([1,2,3])

def greedy_make_change(target,coins=[25,10,5,1])
  return [target] if coins.include?(target)
  return [] if target == 0
  return nil if target < coins.min
  biggest_coin = coins.select{|coin|coin<target}.first
  [biggest_coin] + greedy_make_change(target-biggest_coin)
end
p greedy_make_change(26)
def make_better_change(target,coins)
  return [target] if coins.include?(target)
  return [] if target == 0
  return nil if target < coins.min
  best_change = nil
  coins.each do |coin|
    next if coin > target
    current_change = [coin] + make_better_change(target-coin,coins)
    next if current_change.inject(0){|total,coin| total+coin} == 0
    if best_change.nil? or current_change.length < best_change.length
      best_change = current_change
    end
  end
  best_change
end

p make_better_change(18, [10, 7, 1])
