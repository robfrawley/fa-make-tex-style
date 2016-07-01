
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Run specs'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose    = false
  t.rspec_opts = '--color --order random'
end

RuboCop::RakeTask.new

task default: [:spec, :rubocop]

# EOF
