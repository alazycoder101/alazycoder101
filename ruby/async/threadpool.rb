require('concurrent')

pool = Concurrent::ThreadPoolExecutor.new(
   min_threads: 5,
   max_threads: 55,
   max_queue: 100,
   fallback_policy: :caller_runs
)

0.upto(100) do |i|
  pool.post do
    puts i
    # some parallel work
  end
end

pool.shutdown
pool.wait_for_termination
