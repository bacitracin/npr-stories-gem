# NPR story search that limits results to 5 stories. Using my NPR account key: tracetrace@gmail.com
# Results come back as XML/NPRML, other options including JSON available. More info @ http://www.npr.org/api/inputReference.php
# Potential update: offer choice of # of results

BASE_URL = 'http://api.npr.org/query?apiKey=MDIyODk1NDk0MDE0NTYxNzg5NTdkYjVhZA000&numResults=5&id='

# NPR Program ID Numbers, surprisingly only these 10 shows are offered via the API
ALL_THINGS_CONSIDERED = '2'
ASK_ME_ANOTHER = '58'
FRESH_AIR = '13'
HERE_AND_NOW = '60'
LATINO_USA = '22'
MORNING_EDITION = '3'
TED_RADIO_HOUR = '57'
WAIT_WAIT = '35'
WEEKEND_EDITION_SATURDAY = '7'
WEEKEND_EDITION_SUNDAY = '10'

class NprStories::Scraper

  def initialize(name)
    @name = name
  end

  def pull_stories #returns a list of story hashes
    api_query = "#{BASE_URL + @name}"
    @doc = Nokogiri::XML(open(api_query))
    @stories = @doc.xpath('*//story') # @stories is a Nokogiri::XML::NodeSet of 5 stories
    array_of_stories = []

    @stories.each do |story|
      array_of_stories << {
        :story_title => story.css('title').first.text,
        :program_title => story.css('program')[0].text,
        :story_date => story.css('storyDate')[0].text,
        :teaser => story.css('teaser')[0].text,
        :story_url => story.css('link')[0].text,
        :topic => story.css('slug')[0].text}
    end
    array_of_stories
  end

end