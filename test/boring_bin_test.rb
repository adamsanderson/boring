require 'minitest/autorun'

class BoringBinTest < Minitest::Test
  ROOT_PATH = File.dirname(__FILE__) + "/../"
  BIN_PATH = ENV['BIN_PATH'] || ROOT_PATH + "bin/boring"  
  
  def test_scrubs_piped_input
    input  = "[1;31mFailure![22m"
    output = pipe(input)
    
    assert_equal "Failure!", output
  end
  
  def test_scrubs_file
    out = bin(ROOT_PATH + "test/fixtures/escaped.txt")
    expected = IO.read(ROOT_PATH + "test/fixtures/escaped_expected.txt")
    
    assert_equal expected, out
  end
  
  def test_prints_version
    out = bin("--version")
    
    assert_equal Boring::VERSION, out
  end
  
  def test_prints_usage_in_help
    out = bin("--help")
    
    assert_includes out, BIN_PATH
  end
  
  private
  
  def bin(*arguments)
    stdout = `#{BIN_PATH} #{arguments.join(' ')}`
    stdout.chomp
  end
  
  def pipe(*arguments)
    stdin = arguments.pop
    IO.popen "#{BIN_PATH} #{arguments.join(' ')}", "r+" do |io|
      io.write(stdin)
      io.close_write
      io.read
    end  
  end
  
end