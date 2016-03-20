# NPR story search using my NPR account key: tracetrace@gmail.com
# Results come back as XML/NPRML, other options including JSON available. More info @ http://www.npr.org/api/inputReference.php
# Potential update: offer choice of # of results
BASE_URL = 'http://api.npr.org/query?apiKey=MDIyODk1NDk0MDE0NTYxNzg5NTdkYjVhZA000&id='

class NprStories::Story

  attr_accessor :story_title, :program_title, :story_date, :teaser, :story_url, :topic

  @@stories = []

  def save
    @@stories << self
  end

  def self.all #Returns all scraped stories from all programs
    @@stories
  end

  def display_story_details(program)
    program.each_with_index do |story, index|
      puts "Story ##{index + 1}"
      puts "Story Title: #{story[:story_title]}"
      puts "Program: #{story[:program_title]}"
      puts "Date: #{story[:story_date]}"
      puts "Teaser: #{story[:teaser]}"
      puts "Url: #{story[:story_url]}"
      puts "Main Topic: #{story[:topic]}"
      puts "------------------------------"
    end
  end

end