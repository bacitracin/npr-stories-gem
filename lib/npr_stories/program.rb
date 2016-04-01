class NprStories::Program

  attr_accessor :program_title, :search_id, :additional_info, :stories

  @@programs = [] #all programs

  def initialize
    @stories = []  #all stories for this program
    @@programs << self
  end

  def self.all
    @@programs
  end

end

