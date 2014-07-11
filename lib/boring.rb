require_relative './version'

class Boring
  # ANSI Escape sequence byte ranges:
  # 
  # CSI Parameter bytes:    "0123456789:;<=>?"
  # CSI Intermediate bytes: " !\"\#$%&'()*+,-./"
  # CSI Finishing byte:     "@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
  #
  # References: http://en.wikipedia.org/wiki/ANSI_escape_code
  #             https://www.gnu.org/software/teseq/manual/html_node/Escape-Sequence-Recognition.html
  #
  ESCAPE_SEQUENCE = /
    \x1B             # Escape sequences start with an ESC char
    ( 
      [\x20-\x2F]*
      [\x40-\x5A\x5C-\x7E]
      
      |
      
      \[               # Start CSI sequence
      [\x30-\x3F]+     # CSI Parameter bytes
      [\x20-\x2F]*     # CSI Intermediate bytes
      [\x40-\x7E]      # CSI Finishing byte  
    )
  /x
  
  # Default escape replacement
  REPLACEMENT = ""
  
  attr_reader :replacement
  
  # Create a new Boring string scrubber.  An optional replacement string may be used
  # for any ANSI escape sequences.
  def initialize(replacement=REPLACEMENT)
    @replacement = replacement
  end
  
  # Pipe data from io_in to io_out and scrub it along the way.
  def pipe(io_in, io_out)
    # Since we know that an escape may not contain a newline, we can process
    # this line by line.
    io_in.each_line do |line|
      io_out << scrub(line)
    end
  end
  
  # Removes escape sequences from str.
  def scrub(str)
    str.gsub(ESCAPE_SEQUENCE, replacement)
  end
  
  # Removes escape sequences from str in place.
  def scrub!(str)
    str.gsub!(ESCAPE_SEQUENCE, replacement)
    str
  end
  
end