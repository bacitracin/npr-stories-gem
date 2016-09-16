class NprStories::Scraper

# apiKey is not connected to to my account
BASE_URL = 'http://api.npr.org/query?apiKey=MDIyODk1NDk0MDE0NTYxNzg5NTdkYjVhZA000&id='

#scrape_programs - head over to NPR programs page, scrape data & instantiate new Program objects
#scrape stories - grabs/creates the stories for a particular programs

  def scrape_programs
    doc = Nokogiri::XML(open('http://api.npr.org/list?id=3004'))
    programs = doc.xpath('*//item')
    programs.each do |program|
      new_program = NprStories::Program.new 
      new_program.program_title = program.search('title').text
      new_program.search_id = program.attributes["id"].value.to_i
      new_program.additional_info = program.search('additionalInfo').text
    end
  end

  def scrape_stories(program) #returns a list of story hashes for the show entered
    api_query = "#{BASE_URL + program.search_id.to_s}"
    doc = Nokogiri::XML(open(api_query))
    @program_stories = doc.xpath('*//story') # @progam_stories is a Nokogiri::XML::NodeSet of stories
    @program_stories.each do |nokogiri_story|
      new_story = NprStories::Story.new
      new_story.set_attributes_from_web(nokogiri_story)
      program.stories << new_story # add new story to program's stories array
    end
    program.stories
  end

end

