
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

module Serif

  module Repository

    class IconStyleRepo

      def initialize(provider)
        @provider = provider
      end

      def release
        @provider.release
      end

      def icons
        @provider.icons.map {|v| icon_expand *v }
      end

      private

      def icon_expand(icon, code)
        v = {:class => icon_key(icon), :name => icon_name(icon), :code => icon_code(code), :ccb => '}'}
      end

      def icon_key(icon)
        sanitize icon[3..-1].downcase
      end

      def icon_name(icon)
        n = icon.split('-').collect(&:capitalize).join
        sanitize n[0, 1].downcase + n[1..-1]
      end

      def icon_code(code)
        sanitize code[2..-1].upcase
      end

      def sanitize(s)
        s.to_s.gsub("\n", '')
      end

    end

  end

end

# EOF
