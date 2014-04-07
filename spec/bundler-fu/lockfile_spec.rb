# --                                                            ; {{{1
#
# File        : bundler-fu/lockfile_spec.rb
# Maintainer  : Felix C. Stegerman <flx@obfusk.net>
# Date        : 2014-04-07
#
# Copyright   : Copyright (C) 2014  Felix C. Stegerman
# Licence     : LGPLv3+
#
# --                                                            ; }}}1

require 'bundler-fu/lockfile'
require 'yaml'

bfl = BundlerFu::Lockfile

describe 'bundler-fu/lockfile' do

  context 'parse_file' do
    it 'Gemfile.lock.1 == Gemfile.yaml.1' do
      x = bfl.parse_file('test/Gemfile.lock.1')
      y = YAML.load_file('test/Gemfile.yaml.1')
      expect(x).to eq(y)
    end
    it 'Gemfile.lock.2 == Gemfile.yaml.2' do
      x = bfl.parse_file('test/Gemfile.lock.2')
      y = YAML.load_file('test/Gemfile.yaml.2')
      expect(x).to eq(y)
    end
  end

end

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
