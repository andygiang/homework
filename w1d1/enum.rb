def factors(num)
  (1..num).select {|i| num%i==0}
end

def subwords(str,dictionary)
  dictionary.select do |word|
    str =~ Regexp.new(word)
  end
end

def doubler(array)
  array.map {|int|int*2}
end
class Array
  def my_each(&block)
    for i in 0...self.length
      yield(self[i])
    end
    return self
  end
  def my_map(&block)
    map = []
    for i in 0...self.length
      map << yield(self[i])
    end
    map
  end
  def my_select(&block)
    good = []
    for i in 0...self.length
      good << self[i] if yield(self[i])
    end
    good
  end
  def my_inject(memo=nil)
    if memo.nil?
      memo = self.first
      array = self[1..-1]
    else
      array = self
    end
    array.each do |el|
      memo = yield(memo,el)
    end
    memo
  end
end
def concatenate(strings)
  strings.inject('') {|joined,words| joined + words}
end
