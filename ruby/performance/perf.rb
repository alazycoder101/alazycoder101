require "memory_profiler"
require "yaml"

mappings = nil

report = MemoryProfiler.report do
  mappings = YAML.load_file("./config/mappings.yml")
end

report.pretty_print