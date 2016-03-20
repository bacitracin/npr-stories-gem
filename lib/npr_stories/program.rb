class NprStories::Program

  attr_accessor :program_title, :search_id, :additional_info, :stories

  @@programs = []

  def initialize(program_title = nil, search_id = nil)
    @program_title = program_title
    @search_id = search_id
    @stories = []
    @@programs << self
  end

  def self.all
    @@programs
  end

end

