
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

require 'serif/version'

module Serif

  NAME = 'serif'

  SUMMARY = 'A simple CLI utility intended as ancilary tool for LaTeX projects that implements font management actions and icon font style class generation.'

  DESCRIPTION = "#{SUMMARY} Actions include the ability to download fonts from Google Fonts, Git, and explicit URLs (with support for direct resources and ZIP archives). Generation of LaTeX class styles for icon fonts creates a file with command definitions for each icon, allowing for easy usage of the icon set within your LaTeX project."

  AUTHOR = {:name  => 'Rob Frawley 2nd',
            :email => 'rmf@src.run',
            :link  => 'https://src.run/rmf'}

  LICENSE = {:name => 'MIT', 
             :link => 'https://rmf.mit-license.org'}

end

# EOF
