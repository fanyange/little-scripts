require 'open-uri'
require 'mechanize'
require 'json'
require 'pry'

# Log in
# Initialize the agent
a = Mechanize.new { |a| a.user_agent_alias = "Mac Safari"}
# visit the site
a.get 'http://www.douban.com'
# find the login form
f = a.page.forms.last
# log in
f.form_email = "DOUBAN_EMAIL"
f.form_password = "DOUBAN_EMAIL"
# Input chaptcha solution
if captcha_image = f.form_node.at_css('#captcha_image')
  captcha_image_url = captcha_image[:src]
  `open #{captcha_image_url}`
  `osascript -e 'activate application "iTerm"'`
  print "输入验证码："; f['captcha-solution'] = gets.chomp
end
f.submit
# set the Stat Class
class Stat
  attr_reader :user_activities
  def initialize
    @user_activities = Hash.new(0)
  end

  def parse(agent, end_pnum=10)
    (1..end_pnum).each { |i| parse_page(agent, "/?p=#{i}") }
    # ts = []
    # (1..end_pnum).each do |i|
    #   ts << Thread.new { parse_page(agent, "/?p=#{i}") }
    # end
    # ts.each(&:join)
  end

  def to_s
    @user_activities.sort_by { |k,v| -v }.map do |user, acts|
      "#{user}: #{acts}"
    end
  end

  def to_json
    JSON.dump(@user_agent_alias)
  end

  private
  def parse_page(agent, page)
    agent.get page 
    users = agent.page.search('.lnk-people')
    users.inject(@user_activities) do |h, u|
      h[u.text] += 1
      h
    end
    sleep 5
  end
end

sta = Stat.new
sta.parse(a,100)
puts sta.to_s.first(10)
File.open('douban_activities.json', 'w') { |f| f.write sta.to_json }
