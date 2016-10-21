
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'serif/provider/font_asset_fetcher'
require 'serif/repository/font_asset_repo'
require 'serif/output/font_asset_file_writer'

module Serif

  module Executor

    class FontAssetsRunner

      DEFAULT_PATH  = './'
      DEFAULT_FONTS = ['Roboto', 'Lato', 'Fira Mono', 'Fira Sans', 'Source Sans Pro']

      def initialize
        @provider = Serif::Provider::FontAssetFetcher.new
        @repo     = Serif::Repository::FontAssetRepo.new @provider
        @writer   = Serif::Output::FontAssetFileWriter.new @repo
        @path     = nil
      end

      def setup(command)
        command.summary     = 'Font asset downloader'
        command.description = 'Download font assets using Google Fonts, Git remote, or web-hosted ZIP archive.'
        command.syntax      = 'serif download [OPTIONS] -- [FONT] ...'

        command.option '-o', '--path STRING', String, 'File path used for writing the generated LaTeX style class.'
        command.option '-f', '--fonts ARRAY',  Array, 'Comma separated list of fonts name, git remote, or ZIP archive links.'

        command.example 'simplest invokation does not require any options', 'serif download'
        command.example 'custom output path and font selection', 'serif download --path custom/output/path Roboto Lato "Fira Mono" "Fira Sans" "Source Sans Pro"'
      end

      def run(options, arguments)
        command_opts options
        command_args arguments

        @writer.write
      end

      private

      def command_opts(opts)
        default_opts opts

        @writer.path = opts.path
      end

      def default_opts(opts)
        opts.default \
          :path => DEFAULT_PATH
      end

      def command_args(args)
        if args.length > 0
          @provider.fonts = args
        else
          @provider.fonts = DEFAULT_FONTS
        end
      end

    end

  end

end

# EOF
