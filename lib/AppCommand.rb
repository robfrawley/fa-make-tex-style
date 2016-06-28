#!/usr/bin/env ruby

require 'rubygems'
require 'commander'
require_relative 'UrlResourceManager'
require_relative 'TemplateWriter'
require_relative 'FaIconCollection'

class AppCommand
  include Commander::Methods

  VERSION = '1.0.0'

  def initialize
    @icon_collection = FaIconCollection.new
    @url_resource_mg = UrlResourceManager.new @icon_collection
    @template_writer = TemplateWriter.new @url_resource_mg, @icon_collection
    @output_filepath = String.new
    @font_cheatsheet = String.new
  end

  def run
    program :version, VERSION
    program :description, 'Handles various generation tasks for some latex class files as it applies to FontAwesome.'
    program :help, 'Author', 'Rob Frawley 2nd <rmf@src.run>'
    program :help, 'License', 'MIT License (https://rmf.mit-license.org)'

    command :build do |c|
      c.summary = 'Create a new FontAwesome .sty class file from latest font release.'
      c.description = 'Parse the latest icon data from the website and generate a coorosponding STY file for use as a class file within a Latex project.'
      c.syntax = 'fontawesome-make-sty build [<output_filepath>] [<font_cheatsheet_url>]'

      c.option '-o', '--output-filepath STRING', String, 'Output filepath to write generated STY class file.'
      c.option '-c', '--font-cheatsheet STRING', String, 'The CheatSheet URL to use for scraping the current iconset from.'
      c.option '-p', '--project STRING', String, 'Edit the name of the project shown in the copyright of the output file.'
      c.option '-a', '--author STRING', String, 'Edit the author of the project shown in the copyright of the output file.'

      c.action do |args, options|
        options.default \
          :'output_filepath' => 'fontawesome.sty', \
          :'font_cheatsheet' => 'http://fortawesome.github.io/Font-Awesome/cheatsheet/'

        parse_opts options

        @template_writer.write options.output_filepath
      end
    end

    default_command :build
    run!
  end

  private

  def parse_opts(opts)
    say_help if opts.help

    extra = Hash.new
    extra[:project] = opts.project unless opts.project == nil
    extra[:author] = opts.author unless opts.author == nil

    @template_writer.extra extra
    @url_resource_mg.icon_path = opts.font_cheatsheet
  end

  def say_help
    command(:help).run([:suggest])
    exit
  end
end

# EOF
