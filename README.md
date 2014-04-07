[]: {{{1

    File        : README.md
    Maintainer  : Felix C. Stegerman <flx@obfusk.net>
    Date        : 2014-04-07

    Copyright   : Copyright (C) 2014  Felix C. Stegerman
    Version     : v0.0.2

[]: }}}1

[![Gem Version](https://badge.fury.io/rb/bundler-fu.png)](https://badge.fury.io/rb/bundler-fu)

## Description

  bundler-fu - tools for bundler

  `bundler-fu` provides some tools for `bundler` [1], like a
  standalone `Gemfile.lock` parser.

## Examples

[]: {{{1

```ruby
require 'bundler-fu/lockfile'
x = BundlerFu::Lockfile.parse_file('Gemfile.lock')

x[:remote]    # => 'https://rubygems.org/'
x[:platforms] # => ['ruby']

x[:gits]
# => {"rack"=>
#     {:gem=>"rack",
#      :version=>"1.6.0.alpha",
#      :remote=>"https://github.com/rack/rack.git",
#      :revision=>"ce4a3959a5be68684c447ce68c626d0cc84f8c1a",
#      :branch=>"master",
#      :specs=>{"rack"=>{:gem=>"rack", :version=>"1.6.0.alpha", :deps=>{}}}},
#     ... },

x[:paths]
# => {"obfusk-util"=>
#     {:gem=>"obfusk-util",
#      :version=>"0.5.1",
#      :remote=>"/home/felix/dev/lib/rb-obfusk-util",
#      :specs=>
#       {"obfusk-util"=>{:gem=>"obfusk-util", :version=>"0.5.1", :deps=>{}}}},
      ... },

x[:gems]
# => {"rspec-expectations"=>
#     {:gem=>"rspec-expectations",
#      :version=>"2.14.5",
#      :deps=>{"diff-lcs"=>{:gem=>"diff-lcs", :version=>">= 1.1.3, < 2.0"}}},
#     ... }

x[:dependencies]
# => {"obfusk-util"=>
#      {:gem=>"obfusk-util", :version=>nil, :bang=>true, :used=>"0.5.1"},
#     "rack"=>{:gem=>"rack", :version=>nil, :bang=>true, :used=>"1.6.0.alpha"},
#     "rspec"=>{:gem=>"rspec", :version=>nil, :bang=>false, :used=>"2.14.1"},
#     ... }

```

[]: }}}1

## Specs & Docs

```bash
$ rake spec
$ rake docs
```

## TODO

  * specs!
  * more tools!

## License

  LGPLv3+ [2].

## References

  [1] bundler
  --- http://bundler.io

  [2] GNU Lesser General Public License, version 3
  --- http://www.gnu.org/licenses/lgpl-3.0.html

[]: ! ( vim: set tw=70 sw=2 sts=2 et fdm=marker : )
