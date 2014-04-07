# --                                                            ; {{{1
#
# File        : bundler-fu/lockfile.rb
# Maintainer  : Felix C. Stegerman <flx@obfusk.net>
# Date        : 2014-02-20
#
# Copyright   : Copyright (C) 2014  Felix C. Stegerman
# Licence     : LGPLv3+
#
# --                                                            ; }}}1

require 'treetop'

module BundlerFu; module Lockfile

  class ParseFailed < RuntimeError; end

  module RootNode                                               # {{{1

    def _get_deps(deps, w_bang = false)                         # {{{2
      Hash[deps.map do |x|
        v   = x.version.respond_to?(:version) ?
              x.version.version.value.text_value : nil
        g   = x.gem.text_value
        d1  = { gem: g, version: v }
        d2  = w_bang ? d1.merge(bang: !x.bang.text_value.empty?) : d1
        [g, d2]
      end]
    end                                                         # }}}2

    def _get_specs(specs)                                       # {{{2
      Hash[specs.map do |x|
        g = x.gem.text_value
        d = { gem: g, version: x.version.value.text_value,
              deps: _get_deps(x.deps.elements) }
        [g, d]
      end]
    end                                                         # }}}2

    def get_remote
      gems.remote.url.text_value
    end

    def get_platforms
      platforms.platforms.elements.map { |x| x.name.text_value }
    end

    def get_gits                                                # {{{2
      Hash[gits.elements.map do |x|
        b     = x.branch.respond_to?(:branch) ?
                x.branch.branch.text_value : nil
        s     = _get_specs x.specs.specs.elements
        g, v  = s.first[1].values_at(:gem, :version)
        d     = { gem: g, version: v,
                  remote: x.remote.url.text_value,
                  revision: x.revision.revision.text_value,
                  branch: b, specs: s }
        [g, d]
      end]
    end                                                         # }}}2

    def get_paths                                               # {{{2
      Hash[paths.elements.map do |x|
        s     = _get_specs x.specs.specs.elements
        g, v  = s.first[1].values_at(:gem, :version)
        d     = { gem: g, version: v,
                  remote: x.remote.url.text_value, specs: s }
        [g, d]
      end]
    end                                                         # }}}2

    def get_gems
      _get_specs gems.specs.specs.elements
    end

    def get_dependencies
      _get_deps dependencies.dependencies.elements, true
    end

  end                                                           # }}}1

  Treetop.load File.expand_path('../lockfile.tt', __FILE__)

  def self.parse(data)                                          # {{{1
    p     = LockfileParser.new
    r     = p.parse(data) or raise ParseFailed, p.failure_reason
    gits  = r.get_gits
    paths = r.get_paths
    gems  = r.get_gems
    deps  = _merge_versions r.get_dependencies, gits, paths, gems
    { remote: r.get_remote, platforms: r.get_platforms,
      gits: gits, paths: paths, gems: gems, dependencies: deps }
  end                                                           # }}}1

  def self.parse_file(filename)
    parse File.read(filename)
  end

  def self._merge_versions(deps, gits, paths, gems)
    Hash[deps.map do |(g,d)|
      v = (gems[g] || gits[g] || paths[g])[:version]
      [g, d.merge(used: v)]
    end]
  end

end; end

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
