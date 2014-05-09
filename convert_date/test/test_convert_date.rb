require "test/unit"

require_relative "../lib/convert_date"

class TestConvertDate < Test::Unit::TestCase

    @@converter = Converter.new

  def test_convert_date_to_underline_format
    origin_format = "20140501"
    result = @@converter.parse(origin_format).to_underscore
    assert_equal result, "2014-5-1"
  end

  def test_convert_date_to_zero_padded
    origin_format = "2014-01-01"
    result = @@converter.parse(origin_format).to_zero_padded
    assert_equal result, "20140101"
  end
end

