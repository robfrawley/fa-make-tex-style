
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'handlebars'

module Serif

  module Templating

    class Engine

      def initialize(template_path)
        @path    = template_path
        @addopts = Hash.new
      end

      def tplopts=(opts)
        @addopts.merge!(opts)
      end

      def render
        engine.call options.merge(@addopts.each {|k, v| @addopts[k] = safe_option(v) })
      end

      private

      def engine
        environment.compile(template_source)
      end

      def template_source
        template_path.read
      end

      def template_path
        Pathname.new(File.dirname(__FILE__)) + Pathname.new(@path)
      end

      def environment
        Handlebars::Context.new
      end

      def options
        {:__rb => '}', :__lb => '{'}
      end

      def safe_option(string)
        proc { Handlebars::SafeString.new(string) }
      end

      def date_string
        Date.today.strftime('%04Y/%02m/%02d').to_s
      end
    end

  end

end

# EOF
