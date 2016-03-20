class NprStories::Scraper

BASE_URL = 'http://api.npr.org/query?apiKey=MDIyODk1NDk0MDE0NTYxNzg5NTdkYjVhZA000&id='

#scrape_programs - head over to NPR programs page, scrape data & instantiate new Program objects
#scrape stories - grabs the stories for a particular program, scrapes another XML page & creates Story objects

  def scrape_programs
    @doc = Nokogiri::XML(open('http://api.npr.org/list?id=3004'))
    @programs = @doc.xpath('*//item')
    @programs.each do |program|
      new_program = NprStories::Program.new #program is added to all programs in initialize
      new_program.program_title = program.search('title').text
      new_program.search_id = program.attributes["id"].value.to_i
      new_program.additional_info = program.search('additionalInfo').text
    end
  end

  def scrape_stories(program) #returns a list of story hashes for the show entered
    api_query = "#{BASE_URL + program.search_id.to_s}"
    doc = Nokogiri::XML(open(api_query))
    @program_stories = doc.xpath('*//story') # @stories is a Nokogiri::XML::NodeSet of stories
    @program_stories.each do |story|
      new_story = NprStories::Story.new
      new_story.story_title = story.search('title').first.text
      new_story.program_title = story.search('program')[0].text
      new_story.story_date = story.search('storyDate')[0].text
      new_story.teaser = story.search('teaser')[0].text
      new_story.story_url = story.search('link')[0].text
      new_story_topic = story.search('slug')[0].text
      new_story.save
      program.stories << new_story
    end
    program.stories
  end

end

