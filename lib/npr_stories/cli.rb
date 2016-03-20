class NprStories::CLI

  def call #starts up program with bin/npr_stories command in cli
    puts "Welcome to NPR!"
    NprStories::Scraper.new.scrape_programs
    list_programs
    choose_program
  end

  def list_programs
    puts "Information on the following NPR programs is available:"
    NprStories::Program.all.each_with_index do |program, index|
      puts "#{index + 1}. #{program.program_title}"
    end
  end

  def choose_program
    program_choice = ""
    program_choice = gets.strip.downcase

    if program_choice.to_i-1 <= NprStories::Program.all.size
      program = NprStories::Program.all[program_choice.to_i-1]
      program_stories = NprStories::Scraper.new.scrape_stories(program)

      program_stories.each_with_index do |story, index|
        puts "#{index + 1}. #{story.story_title}"
        puts "Date: #{story.story_date}"
        puts "Teaser: #{story.teaser}"
        puts "------------------------------"
      end
    end
  end

  def choose_story
    story_choice = nil
    until choice == 'exit'
      puts "Pick a story to read or go back to main menu with 'exit'"
      story_choice = gets.strip.downcase.to_i
      NprStories::Story.display_story_details
    end
  end


end