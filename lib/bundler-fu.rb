require 'treetop'

module BundlerFu
  Treetop.load File.expand_path('../bundler-fu.tt', __FILE__)

  def self.parse_lockfile(filename)
    r = BundlerFuParser.new.parse File.read(filename)
    { gems: r.get_gems, platforms: r.get_platforms,
      dependencies: r.get_dependencies }
  end
end
