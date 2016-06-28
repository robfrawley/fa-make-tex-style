#!/usr/bin/env ruby

require 'rubygems'
require 'open_uri_redirections'
require 'nokogiri'

class UrlResourceManager
  def initialize(icon_collection)
    @icon_collection = icon_collection
    @icon_path, @raw, @dom = nil, nil, nil
  end

  attr_accessor :icon_path

  def fa_version
    ver_sentence = source.css('div.jumbotron > div.container > p')
    ver_sentence.to_s.match(/(\d+\.\d+\.\d+)/)
  end

  def fa_iconset
    source.css('div.row > div').each do |div|
      div.css('small,i').map { |l| l.unlink }
      code = div.css('span').text.match(/(#[a-z0-9]{4,6})/).to_s
      div.css('span').map { |l| l.unlink }
      icon = div.text.match(/(fa-[a-z-]+?)\s/).to_s

      unless code.length == 0 || icon.length == 0
        @icon_collection.add icon, code
      end
    end
  end

  private

  def source
    @src ||= Nokogiri.HTML(fetch)
  end

  def fetch
    @raw ||= open(@icon_path, :allow_redirections => :safe) { |f| f.read }
  end
end

# EOF
