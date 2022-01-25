class Array
  # 插入排序
  def insert_sort!
    (0...self.length).to_a.each do |j|
      key = self[j]
      i = j - 1;
      while i >= 0 and self[i] > key
        self[i+1] = self[i]
        i = i-1
      end
      self[i+1] = key
    end
    self
  end

  # 快速排序
  def quick_sort!
    return [] if self.empty?
    x, *a = self
    left, right = a.partition{|t| t < x}
    left.quick_sort + [x] + right.quick_sort
  end

  # 冒泡排序
  def bubble_sort!
    f = 1
    while f < self.length
      (0...(self.length-f)).to_a.each do |i|
        self[i], self[i+1] = self[i+1], self[i] if self[i] > self[i+1]
      end
      f += 1
    end
    self
  end

  # 鸡尾酒排序(>_<)
  def cocktail_sort!
    f  = 0
    while f < self.length/2
      i = 0
      while i < self.length - 1
        self[i], self[i+1] = self[i+1], self[i] if self[i] > self[i+1]
        i += 1;
      end
      t = self.length - 1
      while t > 0
         self[t], self[t-1] = self[t-1], self[t] if self[t] < self[t-1]
         t -= 1
      end 
      f += 1
    end
    self
  end

  # 合并排序
  def merge_sort!
    return self if self.size <= 1
    left = self[0, self.size/2]
    right = self[self.size/2, self.size - self.size/2]
    Array.merge(left.merge_sort, right.merge_sort)
  end

  def self.merge(left, right)
    sorted = []
    until left.empty? or right.empty?
        sorted << (left.first <= right.first ? left.shift : right.shift)
    end
    sorted + left + right
  end

  # heap排序
  def heap_sort!
    # in pseudo-code, heapify only called once, so inline it here
    ((length - 2) / 2).downto(0) {|start| siftdown(start, length - 1)}

    # "end" is a ruby keyword
    (length - 1).downto(1) do |end_|
      self[end_], self[0] = self[0], self[end_]
      siftdown(0, end_ - 1)
    end
    self
  end

  def siftdown(start, end_)
    root = start
    loop do
      child = root * 2 + 1
      break if child > end_
      if child + 1 <= end_ and self[child] < self[child + 1]
        child += 1
      end
      if self[root] < self[child]
        self[root], self[child] = self[child], self[root]
        root = child
      else
        break
      end
    end
  end

  %w(insert quick bubble cocktail merge heap).each do |metd|
    define_method("#{metd}_sort") do
      self.dup.send("#{metd.to_s}_sort!") 
    end
  end
end

p b = ((1..100).to_a + (20..80).to_a).shuffle.sample(19)
p b.methods.grep /_sort/
p b.insert_sort
p b.bubble_sort
p b.quick_sort
p b.cocktail_sort
p b.merge_sort
p b.heap_sort
{"mode":"full","isActive":false}