require 'benchmark'
require 'json'
require 'oj'
require 'rails'
require 'debug'

NUMBER = 10_000
NUMBER = 1

def run(result)
  json = File.read('test.json')
  result[:parse] << Benchmark.ms {
    NUMBER.times do
      JSON.parse(json)
    end
  }
  puts "parse #{result[:parse].last}"

  hash = JSON.parse(json)
  result[:to_json] << Benchmark.ms {
    NUMBER.times do
      hash.to_json
    end
  }
  puts "to_json #{result[:to_json].last}"

  hash = JSON.parse(json)
  result[:dump] << Benchmark.ms {
    NUMBER.times do
      JSON.dump(hash)
    end
  }
  puts "dump #{result[:dump].last}"

  hash = JSON.parse(json)
  result[:pretty_generate] << Benchmark.ms {
    NUMBER.times do
      JSON.pretty_generate(hash)
    end
  }
  puts "pretty_generate #{result[:pretty_generate].last}"
end

json_result = {
  parse: [],
  to_json: [],
  dump: [],
  pretty_generate: []
}
10.times { run(json_result) }

Oj.optimize_rails()

oj_result = {
  parse: [],
  to_json: [],
  dump: [],
  pretty_generate: []
}
10.times { run(oj_result) }

[json_result, oj_result].each do |result|
  result.each do |k, v|
    result[k] = v.map(&:to_f).sum / v.size
  end
end

pp json_result
pp oj_result
