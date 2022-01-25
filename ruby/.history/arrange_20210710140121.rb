#题目1：有1、2、3、4个数字，能组成多少个互不相同且无重复数字 的三位数？都是多少？

def arrange(nums)
    case nums.length
    when 1
        [nums]
    else
        result = []
        (1..nums.size).each { |i|
            puts i
          num = nums[i-1]
          other = nums.dup
          other.delete_at(i-1)
          puts other.inspect
          res = arrange(other)
          result << res.map{|x| [num] + x}
        }
        result
    end
end

#puts arrange([1,2,3,4,5]).inspect
puts arrange([1,2]).inspect
#puts arrange([1,2,3]).inspect