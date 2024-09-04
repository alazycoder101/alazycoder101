require 'weakref'

# Create an object and a weak reference to it
original_object = "This is a string"
weak_reference = WeakRef.new(original_object)

# Check if the object is still alive and print it
if weak_reference.weakref_alive?
  puts weak_reference.__getobj__
end

# Remove the strong reference to the object
original_object = nil

# Give the garbage collector some time to collect the object
GC.start

# Check if the object is still alive (it should be false now)
if weak_reference.weakref_alive?
  puts "The object is still alive."
else
  puts "The object has been garbage collected."
end

# Attempt to access the object (this will raise an error if collected)
begin
  puts weak_reference.__getobj__
rescue WeakRef::RefError
  puts "The referenced object has been garbage collected."
end
