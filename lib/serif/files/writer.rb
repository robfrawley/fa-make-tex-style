
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

module Serif

  module Files

    class FileWriter

      def initialize
        @path = nil
        @data = nil
      end

      attr_accessor :path
      attr_accessor :data

      def write
        write_data_to_file
      end

      private

      def write_data_to_file
        path = File.dirname(@path)
        unless Dir.exist?(path)
          Dir.mkdir(path, 0700)
        end
        File.open(@path, 'w') { |file| file.write(@data) }
        puts sprintf('Writing %s', @path)
      end

    end

  end

end

# EOF