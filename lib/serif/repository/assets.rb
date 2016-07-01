
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

    class AssetRepository

      def initialize(provider)
        @provider = provider
      end

      def font_files
        @fonts ||= @provider.assets
        @fonts
      end

      private

    end

  end

end

# EOF
