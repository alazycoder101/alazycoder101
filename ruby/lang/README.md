```
gem "syntax_tree"
```

```
stree ast path/to/file.rb
stree check path/to/file.rb
stree ctags path/to/file.rb
```

```ruby
class Foo
end

class Bar < Foo
end
```

```yaml
# .rubocop.yml
inherit_gem:
  syntax_tree: config/rubocop.yml
```
---
https://github.com/ruby-syntax-tree/syntax_tree


