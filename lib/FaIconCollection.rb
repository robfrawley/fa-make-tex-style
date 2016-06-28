#!/usr/bin/env ruby

require 'rubygems'

class FaIconCollection
  def initialize
    @icons = Array.new
  end

  attr_accessor :icons

  def add(icon, code)
    @icons << {:identity => sanitize_identity(icon), :name => sanitize_name(icon), :code => sanitize_code(code), :ccb => '}'}
  end

  private

  def sanitize_identity(icon)
    sanitize_return icon[3..-1].downcase
  end

  def sanitize_name(icon)
    icon_name = icon.split('-').collect(&:capitalize).join
    icon_name = icon_name[0, 1].downcase + icon_name[1..-1]
    sanitize_return icon_name
  end

  def sanitize_code(code)
    sanitize_return code[2..-1].upcase
  end

  def sanitize_return(r)
    r.to_s.gsub("\n", '')
  end
end

# EOF
