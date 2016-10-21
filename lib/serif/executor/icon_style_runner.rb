
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'serif/provider/icon_style_fetcher'
require 'serif/repository/icon_style_repo'
require 'serif/template/icon_style_engine'
require 'serif/output/icon_style_file_writer'

module Serif

  module Executor

    class IconStyleRunner

      DEFAULT_RESOURCE     = 'http://fortawesome.github.io/Font-Awesome/cheatsheet/'
      DEFAULT_PATH         = 'FontAwesome.sty'
      DEFAULT_COPY_PROJECT = 'src-run/serif'
      DEFAULT_COPY_AUTHOR  = 'Rob Frawley 2nd <rmf@src.run>'

      def initialize
        @provider = Serif::Provider::IconStyleFetcher.new
        @repo     = Serif::Repository::IconStyleRepo.new(@provider)
        @engine   = Serif::Template::IconStyleEngine.new(@repo)
        @writer   = Serif::Output::IconStyleFileWriter.new(@engine)
      end

      def setup(command)
        command.summary     = 'FontAwesome style class generator'
        command.description = 'Build a FontAwesome style class that includes command definitions for each icon, allowing for easy and straight-forward usage within LaTeX documents.'
        command.syntax      = 'serif generate [OPTIONS] --'

        command.option '-r', '--resource STRING',     String, 'The project link referencing all project icons and used as the source for genrating the output file.'
        command.option '-o', '--path STRING',         String, 'File path used for writing the generated LaTeX style class.'
        command.option '-P', '--package STRING',      String, 'Set style package name instead of relying on auto-naming using output path.'
        command.option '-p', '--copy-project STRING', String, 'Project name written within the file-level copyright (doc-block) of the build output file.'
        command.option '-a', '--copy-author STRING',  String, 'Author string written within the file-level copyright (doc-block) of the build output file.'

        command.example 'simplest invokation does not require passing any options', 'latex-style-builder fontawesome'
        command.example 'use-provided output path and style package name', 'latex-style-builder fontawesome -o the/output/file/path.sty -P CustomPackageName'
      end

      def run(options, arguments)
        command_opts options

        @writer.write
      end

      private

      def command_opts(opts)
        default_opts opts

        @writer.path       = opts.path
        @provider.resource = opts.resource
        @engine.tplopts    = template_opts(opts)
        @package           = package_name(opts)
      end

      def default_opts(opts)
        opts.default \
          :resource  => DEFAULT_RESOURCE, \
          :path      => DEFAULT_PATH, \
          :c_project => DEFAULT_COPY_PROJECT, \
          :c_author  => DEFAULT_COPY_AUTHOR
      end

      def template_opts(opts)
        tpl_opts = Hash.new
        tpl_opts[:project] = opts.c_project if opts.c_project
        tpl_opts[:author]  = opts.c_author  if opts.c_author
        tpl_opts
      end

      def package_name(opts)
        opts.package ? opts.package : package_create_name(opts)
      end

      def package_create_name(opts)
        name = sprintf '%s/%s', File.dirname(opts.path).to_s, File.basename(opts.path, '.sty').to_s
        name = name[2..-1] if name[0..1] == './'
        name
      end

    end

  end

end

# EOF
