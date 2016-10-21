
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'open_uri_redirections'
require 'nokogiri'

module Serif

  module Provider

    class IconStyleFetcher

      def initialize
        @resource = nil
        @src      = nil
        @dom      = nil
        @icons    = Array.new
      end

      attr_writer :resource

      def release
        dom.css('div.jumbotron > div.container > p').to_s.match(/(\d+\.\d+\.\d+)/).to_s
      end

      def icons
        icons_from_dom.reject! { |x, v| x == nil || v.length == 0 }
      end

      private

      def icons_from_dom
        dom.css('div.row > div').map { |x| parse_div(x) }
      end

      def parse_div(div)
        div.css('small,i').map {|l| l.unlink }
        code = div.css('span').text.match(/(#[a-z0-9]{4,6})/).to_s.gsub("\n", '')

        div.css('span').map { |l| l.unlink }
        icon = div.text.match(/(fa-[a-z0-9-]+?)\s/).to_s.gsub("\n", '')

        unless code.length == 0 && icon.length == 0
          return [icon, code]
        end
      end

      def dom
        @dom ||= Nokogiri.HTML(src)
      end

      def src
        @src ||= open(@resource, :allow_redirections => :safe) {|f| f.read }
      end

    end

  end

end

# EOF
