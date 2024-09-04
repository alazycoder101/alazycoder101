# 定义一个回调函数来处理跟踪事件
trace_func = proc do |event, file, line, id, binding, klass|
  # 检查事件类型
  case event
  when 'call', 'c-call'
    # 检查是否是 Enumerable 的方法
    if klass == Enumerable || klass.ancestors.include?(Enumerable)
      puts "Calling #{id} from #{file}:#{line}"
    end
  when 'return', 'c-return'
    # 检查是否是 Enumerable 的方法返回
    if klass == Enumerable || klass.ancestors.include?(Enumerable)
      puts "Returning from #{id} at #{file}:#{line}"
    end
  end
end

# 设置跟踪函数
set_trace_func trace_func

# 定义一个类来使用 Enumerable 方法
class MyArray < Array
  include Enumerable
end

# 创建 MyArray 的实例并调用 Enumerable 方法
ary = MyArray.new [1, 2, 3]
ary.map { |x| x * 2 }