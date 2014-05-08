require 'date'
require 'fileutils'

class Converter
  def initialize(str)
    @time = Date.parse(str)
  end

  def to_underscore
    @time.strftime("%Y-%-m-%-d")
  end

  def to_zero_padded
    @time.strftime("%Y%m%d")
  end
end


def filename_convert
  # Dir.chdir('/Users/maorui/')
  Dir.entries('.').each do |filename|
    if m = filename.match(/^([0-9-]+)\.md$/)
      new_date_format = Converter.new(m[1]).to_underscore
      new_filename = "#{new_date_format}.md"
      FileUtils.mv(filename, new_filename) unless new_filename == filename
    end
  end
end