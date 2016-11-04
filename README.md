# TerminalTable
[![Build Status](https://travis-ci.org/benoist/terminal_table.cr.svg?branch=master)](https://travis-ci.org/benoist/terminal_table.cr)

Terminal Table is a simple ASCII table generator written in Crystal.
This code was inspired by Terminal Table Ruby implementation https://github.com/tj/terminal-table

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  terminal_table:
    github: benoist/terminal_table.cr
```


## Usage


```crystal
require "terminal_table"

# Table with headings
table = TerminalTable.new
table.headings = ["Char", "Num"]
table << ["a", 1]
table << ["b", 2]
table << ["c", 3]
puts table.render
+------+-----+
| Char | Num |
+------+-----+
| a    | 1   |
| b    | 2   |
| c    | 3   |
+------+-----+

# Table with a separator for each row
table = TerminalTable.new
table.headings = ["Char", "Num"]
table.separate_rows = true
table << ["a", 1]
table << ["b\nc", 2]
table << ["d", 3]
puts table.render
+------+-----+
| Char | Num |
+------+-----+
| a    | 1   |
+------+-----+
| b    | 2   |
| c    |     |
+------+-----+
| d    | 3   |
+------+-----+
```



## TODO

- [] Cell alignment
- [] Colspans

## Contributing

1. Fork it ( https://github.com/benoist/terminal_table.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [benoist](https://github.com/benoist) Benoist Claassen - creator, maintainer
