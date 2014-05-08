require 'active_support/inflector'

class TimeString
  def initialize(str)
    if m = str.match(/\A([0-1][0-9]|2[0-4]):([0-5][0-9]):([0-5][0-9](\.\d{2})?)/)
      @hour   = m[1].to_i
      @min    = m[2].to_i
      @sec    = m[3].to_f
    else
      raise SyntaxError, "Invalid duration time format, need hh:mm:ss(.nn)"
    end

    def to_a
      [@hour, @min, @sec].zip(%w[hour minite second]).map { |count, unit| count.numbers_of_(unit) }.compact
    end

    def to_sentence
      to_a.join(', ') + '.'
    end
  end
end

class Numeric
  def numbers_of_(sth)
    self == 0 ? nil : "#{self} #{sth.pluralize(self)}"
  end
end