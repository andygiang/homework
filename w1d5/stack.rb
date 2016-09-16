class Stack
    def initialize(stack=[])
      @stack = stack
    end

    def add(el) #lifo
      @stack.push(el)
    end

    def remove
      @stack.pop
    end

    def show
      @stack
    end
end
