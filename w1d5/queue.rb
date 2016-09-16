class Queue
  def initialize(queue=[])
    @queue = queue
  end
  def enqueue(el)
    @queue.push(el)
  end
  def dequeue(el)
    @queue.shift
  end
  def show
    @queue
  end
end
