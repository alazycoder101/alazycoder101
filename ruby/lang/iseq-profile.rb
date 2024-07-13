require 'profile'

Profile.start('iseq_profile')

# Your code that you want to profile
def my_method
  # Your code here
end

my_method

Profile.stop