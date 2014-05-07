require 'test/unit'
require_relative '../lib/timestring'

class TestTimeStringClass < Test::Unit::TestCase
  def test_invalid_time_format
    assert_raise(SyntaxError) do
      invalid = TimeString.new("889103123")
    end
  end

  def test_valid_time_format
    assert_equal TimeString.new("24:15:39.99").class, TimeString
  end

  def test_time_to_sentence_convert
    result1 = TimeString.new("00:59:30").to_sentence
    assert_equal result1, "59 minites, 30.0 seconds."

    result2 = TimeString.new("12:59:30.99").to_sentence
    assert_equal result2, "12 hours, 59 minites, 30.99 seconds."

    result3 = TimeString.new("12:59:30.00").to_sentence
    assert_equal result3, "12 hours, 59 minites, 30.0 seconds."
  end
end
