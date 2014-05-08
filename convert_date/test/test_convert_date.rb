require "test/unit"

require_relative "../lib/convert_date"

class TestConvertDate < Test::Unit::TestCase

  def test_convert_date_to_underline_format
    origin_format = "20140501"
    result = Converter.new(origin_format).to_underscore
    assert_equal result, "2014-5-1"
  end

  def test_convert_date_to_zero_padded
    origin_format = "2014-01-01"
    result = Converter.new(origin_format).to_zero_padded
    assert_equal result, "20140101"
  end

  def file_name_convert
    Dir.chdir('/Users/maorui/')
    origin_file_name = "20140509.md"
    File.write(origin_file_name,'')
    file_name_convert
    assert(FileTest.exist? "2014-5-9.md")
  end
end

