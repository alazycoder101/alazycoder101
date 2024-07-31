#!/usr/bin/env ruby
require 'benchmark'

N = 4_000_000
str = "https://turtle.learning.re/api/v3/courses/914281/study_times"
re = Regexp.new('api/v3/courses/[0-9]+/study_times').freeze

Benchmark.bm do |b|
  b.report("str.include?('study_times)\t") { N.times { str.include?('aac') && str.include?('bc') } }
  b.report("str =~ re\t")    { N.times { str =~ re } }
end
