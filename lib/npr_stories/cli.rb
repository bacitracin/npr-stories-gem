class NprStories::CLI

  def call
    puts "Welcome to NPR!"
    NprStories::Scraper.new.scrape_programs # get those programs
    choose_program #pick a program to show stories
    puts "See you later!"
  end

  def list_programs
    puts "Information on the following NPR programs is available:"
    NprStories::Program.all.each_with_index do |program, index|
      puts "#{index + 1}. #{program.program_title}"
    end
  end

  def choose_program
    program_choice = nil
    until program_choice == 'exit'
      list_programs
      puts "Pick a program to see recent stories or type 'exit' to leave program"
        program_choice = gets.strip.downcase

        if program_choice.to_i <= NprStories::Program.all.size
          @program = NprStories::Program.all[program_choice.to_i-1] # get the program from the array of programs
          @program_stories = NprStories::Scraper.new.scrape_stories(@program) # create a scraper & pull the stories for that program
          puts "Recent stories from #{@program.program_title}:"
          @program_stories.each_with_index do |story, index|
            puts "#{index + 1}. #{story.story_title}"
            puts "------------------------------"
          end #each_with_index loop
          choose_story
        end #if
      end # loop
    program_choice = nil
  end # choose_program method

  def choose_story
    story_choice = nil
    until story_choice == 'exit'
      puts "Pick a story to see more details or go back to main menu with 'exit'"
      story_choice = gets.strip.downcase

      if story_choice.to_i <= NprStories::Story.all.size
        @story = @program_stories[story_choice.to_i-1]
        puts "#{story_choice}. #{@story.story_title}"
        puts "Program: #{@story.program_title}"
        puts "Date: #{@story.story_date}"
        puts "Teaser: #{@story.teaser}"
        puts "Url: #{@story.story_url}"
        puts "------------------------------"
      end # if loop
    end # until
    puts "Now exiting back to the menu"
  end # choose_story method

end
