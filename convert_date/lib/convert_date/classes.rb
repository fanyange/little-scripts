require 'date'

class Converter
  def initialize
    @time = Date.today
  end

  def parse(str)
    @time = Date.parse(str)
    self
  end

  def to_underscore
    @time.strftime("%Y-%-m-%-d")
  end

  def to_zero_padded
    @time.strftime("%Y%m%d")
  end
end