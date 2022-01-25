#题目1：有1、2、3、4个数字，能组成多少个互不相同且无重复数字 的三位数？都是多少？

def arrange(arr)
    case arr.length do
    when 1
        arr
    when 2
        arr.reverse
    else
        arrange(arr[1..arra.length])
    end
end

puts arrange([1,2,3,4,5])