#题目1：有1、2、3、4个数字，能组成多少个互不相同且无重复数字 的三位数？都是多少？

def arrange(nums)
    case nums.length
    when 1
        [nums]
    else
        (1..res.size/2).each {|i| res
          res = arrange(nums[1..nums.length])
          res.map{|x| x + [nums[0]]}
        }.sum
    end
end

puts arrange([1,2,3,4,5]).inspect
puts arrange([1,2]).inspect
puts arrange([1,2,3]).inspect