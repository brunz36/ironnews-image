require 'open-uri'
require 'nokogiri'

user_1 = User.create(name: "Patrick Miller", email: "pjmiller823@gmail.com", password: "password", password_confirmation: "password")
user_2 = User.create(name: "Bruno Ribeiro", email: "brunz36@gmail.com", password: "test", password_confirmation: "test")

(1..2).each do |page|
  Nokogiri::HTML(open("https://news.ycombinator.com?p=#{page}")).css(".storylink").each_with_index { |article, index| Story.create(title: article.content, url_link: article.values.first) }
end
