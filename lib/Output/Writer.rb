
#
# This file is part of the `src-run/latex-style-builder` project.
#
# (c) Rob Frawley 2nd <rmf@src.run>
#
# For the full copyright and license information, please view the LICENSE.md
# file that was distributed with this source code.
#

class Writer

  def initialize(engine)
    @engine = engine
  end

  def write_file(path)
    write path
  end

  private

  def write(path)
    File.open(path, 'w') {|file| file.write(@engine.render) }
  end

end

# EOF
