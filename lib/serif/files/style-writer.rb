
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'serif/files/writer'

module Serif

  module Files

    class StyleWriter < Serif::Files::FileWriter

      def initialize(engine)
        @engine = engine
        super()
      end

      def write
        @data = @engine.render
        super()
      end

    end

  end

end

# EOF
