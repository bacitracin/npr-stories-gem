class NprStories::Story

  attr_accessor :story_title, :program_title, :story_date, :teaser, :story_url, :program
  @@stories = []  # All stories, all programs

  def save
    @@stories << self  
  end

  def self.all
    @@stories
  end

  def set_attributes_from_web(nokogiri_story)#nokogiri story object node?? thing
    self.story_title = nokogiri_story.search('title').first.text
   # new_story.program = ##### add in stoy's relationship to program object
    self.program_title = nokogiri_story.search('program')[0].text
    self.story_date = nokogiri_story.search('storyDate')[0].text
    self.teaser = nokogiri_story.search('teaser')[0].text
    self.story_url = nokogiri_story.search('link')[0].text
    self.save
  end


end