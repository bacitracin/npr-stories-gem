class NprStories::Program

  attr_accessor :program_title, :search_id, :additional_info, :stories

  @@programs = []

  def initialize
    @stories = []
    @@programs << self
  end

  def self.all
    @@programs
  end

end

