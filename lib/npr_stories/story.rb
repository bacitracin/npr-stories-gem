class NprStories::Story

  attr_accessor :story_title, :program_title, :story_date, :teaser, :story_url, :program
  @@stories = []  # All stories, all programs

  def save
    @@stories << self  
  end

  def self.all
    @@stories
  end

end