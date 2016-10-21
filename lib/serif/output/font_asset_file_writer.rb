
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

    class FontAssetFileWriter < Serif::Output::FileWriter

      def initialize(repo)
        @repo = repo
        @orig = nil
        super()
      end

      def write
        @orig = @path
        @repo.font_files.each do |file|
          @data = File.open(file, "rb").read
          File.delete(file)
          @path = sprintf('%s/font-%s/%s', @orig, file.basename.to_s.match(/[a-zA-Z]+/).to_s.downcase, file.basename.to_s)
          super()
        end
        @path = @orig
      end

    end

  end

end

# EOF
