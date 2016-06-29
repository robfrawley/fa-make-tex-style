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
    @package_name = nil
    @silent = false
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
      c.option '-c', '--font-cheatsheet STRING', String, 'The CheatSheet URL to use for scraping the current icon set from.'
      c.option '-p', '--project STRING', String, 'Edit the name of the project shown in the copyright of the output file.'
      c.option '-a', '--author STRING', String, 'Edit the author of the project shown in the copyright of the output file.'
      c.option '-p', '--package STRING', String, 'Edit the latex sty package name instead of using the default of the output path.'
      c.option '-s', '--silent', 'Disable all command runtime output.'

      c.action do |args, options|
        options.default \
          :'output_filepath' => 'FontAwesome.sty', \
          :'font_cheatsheet' => 'http://fortawesome.github.io/Font-Awesome/cheatsheet/'

        parse_opts options

        say_working
        @template_writer.write @package_name, @output_filepath
        say_operation_overview
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
    @url_resource_mg.icon_path = @font_cheatsheet = opts.font_cheatsheet
    @output_filepath = opts.output_filepath
    @package_name = opts.package if opts.package
    @package_name = package_from_filepath @output_filepath unless @package_name

    @silent = true if opts.silent
  end

  def package_from_filepath(filepath)
    basename = File.basename(filepath, '.sty').to_s
    dirname = File.dirname(filepath).to_s
    package = sprintf '%s/%s', dirname, basename
    package = package[2..-1] if package[0..1] == './'
    package
  end

  def say_help
    command(:help).run([:suggest])
    exit
  end

  def say_working
    puts 'Generating font awesome sty file for latex...' unless @silent
  end

  def say_operation_overview
    stats = {:source_link => @font_cheatsheet,
             :number_of_icons => @icon_collection.icons.length,
             :release_version => @url_resource_mg.fa_version,
             :output_file_path => @output_filepath,
             :package_name => @package_name}

    stats.each do |name, value|
      puts sprintf '%-16s : %s', name.to_s.split('_').select {|w| w.capitalize! || w }.join(' '), value.to_s unless @silent
    end
  end
end

# EOF
