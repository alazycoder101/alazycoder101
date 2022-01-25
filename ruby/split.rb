def split(str)
  word = ''
  words = []
  no_split = false
  str.split('').each do |char|
    case char
    when '['
      no_split = true
    when ']'
      words << word
      word = ''
      no_split = false
    when ' '
      if no_split
        word += char
      else
        words << word
        word = ''
      end
    else
      word += char
    end
  end
  words
end
text = "I like dog [very much]"
puts split(text).inspect
