#!/usr/bin/env ruby
require 'benchmark'

str = "aacaabc"
re = Regexp.new('a+b').freeze

N = 4_000_000

Benchmark.bm do |b|
    b.report("str.inlude? 'a'") { N.times { str.include? 'a' } }
    b.report("str.match re\t") { N.times { str.match re } }
    b.report("str =~ re\t")    { N.times { str =~ re } }
    b.report("str[re]  \t")    { N.times { str[re] } }
    b.report("re =~ str\t")    { N.times { re =~ str } }
    b.report("re.match str\t") { N.times { re.match str } }
    if re.respond_to?(:match?)
        b.report("re.match? str\t") { N.times { re.match? str } }
    end
end

str = "aacaabc"
re = Regexp.new('aac.+bc').freeze

N = 4_000_000

Benchmark.bm do |b|
  b.report("str.inlude?('aac') && str.include?('bc')\t") { N.times { str.include?('aac') && str.include?('bc') } }
  b.report("str =~ re\t")    { N.times { str =~ re } }
end
