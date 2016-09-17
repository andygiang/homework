require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil)
    if accumulator.nil?
      accumulator = self.first
      array = self[1..-1]
    else
      array = self
    end
    array.each do |el|
      accumulator = yield(accumulator,el)
    end
    accumulator
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return false if num <2
  return (2..num/2).none? {|i| num%i==0}
end

def primes(num)
  list = []
  i = 2
  until list.length == num
    list << i if is_prime?(i)
    i+=1
  end
  list
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num==1
  return [1,1] if num==2
  factorials_rec(num-1) + [(num-1) * factorials_rec(num-1).last]
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    dup_hash = Hash.new([])
    self.each_with_index do |value,index|
      dup_hash[value]+=[index]
    end
    dup_hash.select{|key,value| value.length > 1}
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    ss = []
    for i in 0...self.length-1
      for j in i+1...self.length
        substring = self[i..j]
        ss << substring if substring == substring.reverse
      end
    end
    ss
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    return self if self.length <= 1
    prc||= Proc.new {|x,y| x<=>y}
    middle = self.length/2
    left = self[0...middle]
    right = self[middle..-1]
    Array.merge(left.merge_sort(&prc),right.merge_sort(&prc),&prc)
  end

  private
  def self.merge(left, right, &prc)
    sorted = []
    until left.empty? or right.empty?
      order = prc.call(left,right)
      if order == 1
        sorted << right.shift
      else
        sorted << left.shift
      end
    end
    sorted + left + right
  end
end
