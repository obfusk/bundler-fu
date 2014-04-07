require File.expand_path('../lib/bundler-fu/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'bundler-fu'
  s.homepage    = 'https://github.com/obfusk/bundler-fu'
  s.summary     = 'tools for bundler'

  s.description = <<-END.gsub(/^ {4}/, '')
    bundler-fu provides some tools for bundler
  END

  s.version     = BundlerFu::VERSION
  s.date        = BundlerFu::DATE

  s.authors     = [ 'Felix C. Stegerman' ]
  s.email       = %w{ flx@obfusk.net }

  s.licenses    = %w{ LGPLv3+ }

  s.files       = %w{ .yardopts README.md Rakefile } \
                + %w{ bundler-fu.gemspec } \
                + Dir['test/Gemfile.lock.[1-9]'] \
                + Dir['{lib,spec}/**/*.rb']

  s.add_runtime_dependency 'treetop'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.required_ruby_version = '>= 1.9.1'
end
