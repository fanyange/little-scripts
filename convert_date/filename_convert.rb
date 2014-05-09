$:.push File.expand_path('../lib', __FILE__)
require "convert_date"

def filename_convert(path=File.dirname(__FILE__))
  Dir.chdir(File.expand_path(path))
  Dir.entries('.').each do |filename|
    if m = filename.match(/^([0-9-]+)\.md$/)
      new_date_format = Converter.new.parse(m[1]).to_underscore
      new_filename = "#{new_date_format}.md"
      if new_filename == filename
        puts "#{new_filename} already satisfied result format."
      elsif FileTest.exist?(new_filename)
        puts "#{filename} can't be renamed. #{new_filename} already exists, "
      else
        `mv #{filename} #{new_filename}`
        puts "rename #{filename_convert} to #{new_filename}"
      end
    end
  end
end

filename_convert