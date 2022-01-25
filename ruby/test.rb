# you can write to stdout for debugging purposes, e.g.
# puts "this is a debug message"

def solution(y, a, b, w)
  # write your code in Ruby 2.2
  dows = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
  months = %w(January February March April May June July August September October November December)
  days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  leap = (y % 4) == 0
  start_month = months.index(a)
  end_month = months.index(b)
  start_dow_year = dows.index(w)
  # leap year
  if leap && (start_month == 1 || end_month == 1)
    days[1] = 29
  end

  days_from_start = 0
  1.upto(start_month).each do |i|
    days_from_start += days[i-1]
  end

  # calculate start dow
  start_dow = (start_dow_year + days_from_start % 7) % 7

  whole_days = days[start_month] + days[end_month]
  weeks = whole_days / 7
  days_left = whole_days % 7

  end_dow = (start_dow + days_left -1) % 7
  weeks -= 1 if start_dow > 0
  weeks -= 1 if end_dow < 5
  puts "#{y}, #{a}"
  puts "start_dow=#{start_dow}, end_dow=#{end_dow}"
  weeks
end

puts solution(2014, 'April', 'May', 'Wednesday')
puts solution(2021, 'May', 'June', 'Friday')
puts solution(2019, 'February', 'March', 'Tuesday')
