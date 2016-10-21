
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'open_uri_redirections'
require 'net/http'
require 'uri'
require 'zip'

module Serif

  module Provider

    class FontAssetsProvider

      URL_BASE = 'https://fonts.google.com'
      URL_ARGS = '/download?family=%s'

      def initialize
        @fonts = Array.new
        @files = Array.new
        @tmpdir = nil
      end

      attr_accessor :fonts

      def assets
        @fonts.each do |font|
          download font
        end

        @files
      end

      private

      def download(font)
        begin
          open(URI.escape(URL_BASE + sprintf(URL_ARGS, font)), {:allow_redirections => :safe}) { |f| unzip f }
        rescue OpenURI::HTTPError
          puts sprintf('Failed downloading %s', font)
        end
      end

      def unzip(file)
        Zip::File.open(file) do |zip_file|
          zip_file.each { |entry| temp_move entry }
        end
      end

      def temp_move(entry)
        @tmpdir ||= Dir.mktmpdir
        file = Pathname.new(entry.name)

        if file.extname == '.ttf'
          dest_file = sprintf('%s/%s', @tmpdir, file.basename)
          @files << Pathname.new(dest_file)
          entry.extract(dest_file)
        end
      end

    end

  end

end

# EOF
