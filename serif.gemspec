
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'serif/about'

Gem::Specification.new do |spec|
  spec.name        = Serif::NAME
  spec.version     = Serif::VERSION
  spec.summary     = Serif::SUMMARY
  spec.description = Serif::DESCRIPTION
  spec.license     = Serif::LICENSE[:name]
  spec.author      = Serif::AUTHOR[:name]
  spec.email       = Serif::AUTHOR[:email]
  spec.homepage    = Serif::AUTHOR[:link]
  spec.date        = '2016-06-30'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = `git ls-files -z -- {test,spec,features}/*`.split("\x0")
  spec.executables   = `git ls-files -z -- bin/*`.split("\x0").map { |f| File.basename(f) }
  spec.require_paths = ['lib', 'resources']
 
  spec.add_runtime_dependency('commander',             '~> 4.4')
  spec.add_runtime_dependency('open_uri_redirections', '~> 0.2')
  spec.add_runtime_dependency('nokogiri',              '~> 1.6')
  spec.add_runtime_dependency('handlebars',            '~> 0.8')
  spec.add_runtime_dependency('net',                   '~> 0.3')
  spec.add_runtime_dependency('rubyzip',               '~> 1.2')

  spec.add_development_dependency('rspec',         '~> 3.2')
  spec.add_development_dependency('rake',          '~> 11.2')
  spec.add_development_dependency('simplecov',     '~> 0.11')
  spec.add_development_dependency('rubocop',       '~> 0.29')
  spec.add_development_dependency('awesome_print', '~> 1.7')
end

# EOF
