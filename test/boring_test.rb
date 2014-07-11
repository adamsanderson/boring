# encoding: UTF-8

require 'minitest/autorun'
require_relative '../lib/boring'

# For testing IO:
require 'stringio'


class BoringTest < Minitest::Test
  def setup
    @boring = Boring.new
  end
  
  def test_scrubs_escapes
    str = "This contains \e~ an escape ending in ~."
    assert_equal "This contains  an escape ending in ~.", @boring.scrub(str)
  end
  
  def test_scrubs_escapes_with_intermediate_characters
    str = "This contains \e$~ an escape ending in ~."
    assert_equal "This contains  an escape ending in ~.", @boring.scrub(str)
  end
  
  def test_scrubs_escapes_with_non_ascii_chars
    str = "こんにちは\e!!!~こんにちは!"
    assert_equal "こんにちはこんにちは!", @boring.scrub(str)
  end
  
  def test_scrubs_csi_escape_sequences
    str = "\e[6m"
    assert_equal "", @boring.scrub(str)
  end
  
  def test_scrubs_csi_escapes_from_text
    str = "This should \e[6mBlink\e[25m"
    assert_equal "This should Blink", @boring.scrub(str)
  end
  
  def test_scrubs_csi_escapes_from_multi_line_text
    str = "This should\n\e[6mBlink\e[25m"
    assert_equal "This should\nBlink", @boring.scrub(str)
  end
  
  def test_mutating_scrub_should_return_same_object
    str = "This should \e[6mBlink\e[25m"
    @boring.scrub!(str)
    
    assert_equal "This should Blink", str
  end
  
  def test_allows_custom_replacement_characters
    @boring = Boring.new("[esc]")
    str = "This should \e[6mBlink\e[25m"
    
    assert_equal "This should [esc]Blink[esc]", @boring.scrub(str)
  end
  
  def test_can_transform_piped_io
    io_in  = StringIO.new("This should \e[6mBlink\e[25m")
    io_out = StringIO.new("")
    
    @boring.pipe(io_in, io_out)
    assert_equal "This should Blink", io_out.string
  end
  
  def test_can_transform_multi_line_piped_io
    io_in  = StringIO.new("This should \e[6mBlink\e[25m\nand this should not")
    io_out = StringIO.new("")
    
    @boring.pipe(io_in, io_out)
    assert_equal "This should Blink\nand this should not", io_out.string
  end
  
end