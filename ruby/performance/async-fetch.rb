require 'http'

# Define an async method to fetch the page
def fetch_page_async(url)
  HTTP.get_async(url) do |response|
    if response.success?
      puts "Page fetched successfully!"
      puts response.body
    else
      puts "Failed to fetch the page: #{response.status}"
    end
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
  end
end

# Start the async operation
url = 'http://www.google.com'
fetch_page_async(url)

# Keep the main thread alive until the async operation completes
sleep