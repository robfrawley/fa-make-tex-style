#!/usr/bin/env ruby

require 'rubygems'
require 'handlebars'

class TemplateWriter
  TEMPLATE_PATH = File.dirname(__FILE__) + '/../tpl/fontawesome.sty.mustache'
  DEFAULT_AUTHOR = 'Rob Frawley 2nd <rmf@src.run>'
  DEFAULT_PROJECT = 'src-run/project'

  def initialize(url_resource_mg, icon_collection)
    @url_resource_mg = url_resource_mg
    @icon_collection = icon_collection
    @extra_variables = Hash.new
  end

  def extra(variables)
    @extra_variables.merge!(variables)
  end

  def write(file_path)
    get_resources
    content_write file_path, file_contents
  end

  private

  def file_contents
    arguments = {:icons => @icon_collection.icons,
                 :version => @url_resource_mg.fa_version.to_s,
                 :name => 'Font Awesome Icons',
                 :author => proc {Handlebars::SafeString.new(DEFAULT_AUTHOR)},
                 :project => proc {Handlebars::SafeString.new(DEFAULT_PROJECT)},
                 :date => Date.today.strftime('%04Y/%02m/%02d')}
    template.call(arguments.merge(@extra_variables.each { |k, v| @extra_variables[k] = proc {Handlebars::SafeString.new(v)} }))
  end

  def content_write(file_path, file_contents)
    File.open(file_path, 'w') { |file| file.write(file_contents) }
  end

  def template
    engine.compile(File.read(TEMPLATE_PATH))
  end

  def engine
    Handlebars::Context.new
  end

  def get_resources
    @version = @url_resource_mg.fa_version
    @url_resource_mg.fa_iconset
  end
end

# EOF
