
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'commander'
require 'serif/about'
require 'serif/executor/font_assets_runner'
require 'serif/executor/icon_style_runner'

module Serif

  class App

    include Commander::Methods

    def run
      program :version, Serif::VERSION
      program :description, Serif::DESCRIPTION
      program :help, :Author, sprintf('%s <%s> (%s)', Serif::AUTHOR[:name], Serif::AUTHOR[:email], Serif::AUTHOR[:link])
      program :help, :License, sprintf('%s (%s)', Serif::LICENSE[:name], Serif::LICENSE[:link])

      command :generate do |c|
        generate.setup c

        c.action do |args, options|
          generate.run options, args
        end
      end

      command :download do |c|
        download.setup c

        c.action do |args, options|
          download.run options, args
        end
      end

      run!
    end

    private

    def generate
      @generate_executor ||= Serif::Executor::IconStyleRunner.new
    end

    def download
      @download_executor ||= Serif::Executor::FontAssetsRunner.new
    end

  end

end

# EOF
