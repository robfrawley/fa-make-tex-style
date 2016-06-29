#!/usr/bin/env ruby

#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'commander'
require_relative 'Default'
require_relative 'Icon/Repository'
require_relative 'Icon/Provider'
require_relative 'Output/Writer'
require_relative 'Templating/Engine'

class Application

  include Commander::Methods

  VERSION  = '1.0.0'

  def initialize
    @provider = Provider.new
    @repo     = Repository.new @provider
    @engine   = Engine.new @repo
    @writer   = Writer.new @engine
    @package  = nil
    @resource = nil
    @path     = String.new
  end

  def run
    program :version, VERSION
    program :description, 'A LaTeX style class builder for iterative resources that require regular re-generation to keep the style up-to-date with the respective resources.'

    program :help, :Author,  'Rob Frawley 2nd <rmf@src.run>'
    program :help, :License, 'MIT License (https://rmf.mit-license.org)'

    command :fontawesome do |c|
      c.summary     = 'FontAwesome style class generator'
      c.description = 'Build a FontAwesome style class that includes command definitions for each icon, allowing for easy and straight-forward usage within LaTeX documents.'
      c.syntax      = 'latex-style-builder fontawesome [OPTIONS] --'

      c.option '-r', '--resource STRING',  String, 'The project link referencing all project icons and used as the source for genrating the output file.'
      c.option '-o', '--path STRING',      String, 'File path used for writing the generated LaTeX style class.'
      c.option '-P', '--package STRING',   String, 'Set style package name instead of relying on auto-naming using output path.'
      c.option '-p', '--c-project STRING', String, 'Project name written within the file-level copyright (doc-block) of the build output file.'
      c.option '-a', '--c-author STRING',  String, 'Author string written within the file-level copyright (doc-block) of the build output file.'

      c.example 'simplest invokation does not require passing any options', 'latex-style-builder fontawesome'
      c.example 'use-provided output path and style package name', 'latex-style-builder fontawesome -o the/output/file/path.sty -P CustomPackageName'

      c.action do |args, options|
        options.default \
          :resource  => Default::RESOURCE, \
          :path      => Default::PATH, \
          :c_project => Default::C_PROJECT, \
          :c_author  => Default::C_AUTHOR

        command_opts options

        @engine.package = @package
        @writer.write_file @path
      end
    end

    run!
  end

  private

  def command_opts(opts)
    write_help_and_exit if opts.help

    @path              = opts.path
    @resource          = opts.resource
    @provider.resource = opts.resource
    @engine.tplopts    = template_opts(opts)
    @package           = package_build(opts)
  end

  def template_opts(opts)
    tplopts = Hash.new
    tplopts[:project] = opts.c_project if opts.c_project
    tplopts[:author]  = opts.c_author  if opts.c_author

    tplopts
  end

  def package_build(opts)
    pkg = opts.package if opts.package
    pkg = package_create unless pkg

    pkg
  end

  def package_create
    pkg = sprintf '%s/%s', File.dirname(@path).to_s, File.basename(@path, '.sty').to_s
    pkg = pkg[2..-1] if pkg[0..1] == './'

    pkg
  end

  def write_help_and_exit
    command(:help).run([:suggest])
    exit
  end

end

# EOF
