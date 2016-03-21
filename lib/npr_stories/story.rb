# NPR story search using my NPR account key: tracetrace@gmail.com
# Results come back as XML/NPRML, other options including JSON available. More info @ http://www.npr.org/api/inputReference.php
BASE_URL = 'http://api.npr.org/query?apiKey=MDIyODk1NDk0MDE0NTYxNzg5NTdkYjVhZA000&id='

class NprStories::Story

  attr_accessor :story_title, :program_title, :story_date, :teaser, :story_url
  @@stories = []

  def save
    @@stories << self
  end

  def self.all
    @@stories
  end

end