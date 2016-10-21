
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'serif/template/base_engine'

module Serif

  module Template

    class IconStyleEngine < Serif::Template::BaseEngine

      TEMPLATE_FILEPATH = '../../../resources/font-awesome.sty.mustache'

      def initialize(repo)
        @repo     = repo
        @package  = nil

        super TEMPLATE_FILEPATH
      end

      attr_accessor :package

      private

      def options
        {:name    => 'Font Awesome Icon Collection',
         :version => @repo.release,
         :icons   => @repo.icons,
         :package => @package,
         :date    => date_string,
         :ccb     => '}',
         :ocb     => '{'
       }.merge(super)
      end

    end

  end

end

# EOF
