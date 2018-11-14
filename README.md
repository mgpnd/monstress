### Usage:

```ruby
require "monstress"

Monstress.configure do |config|
  config.host = "https://google.com"
  config.basic_auth = ["username", "password"]
end

targets = [
  Monstress::Test::Target.new("/search", 40),
  Monstress::Test::Target.new("/docs", 100),
]

suite = Monstress::Test.Suite.new targets
suite.run!

puts suite.stats
```
