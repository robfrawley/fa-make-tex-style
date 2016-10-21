
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'serif/output/file_writer'

module Serif

  module Output

    class IconStyleFileWriter < Serif::Output::FileWriter

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
