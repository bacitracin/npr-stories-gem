class NprStories::CLI

  def call
    puts "Welcome to NPR!"
    NprStories::Scraper.new.scrape_programs
    choose_program
  end

  def list_programs
    puts "Information on the following NPR programs is available:"
    puts "----------------------------------------------------------------"
    NprStories::Program.all.each_with_index do |program, index|
      puts "#{index + 1}. #{program.program_title}"
    end
    puts "----------------------------------------------------------------"
  end

  def choose_program
    program_choice = nil
    until program_choice == 'exit'
      list_programs
      puts "Select a program by number to see recent stories or type 'exit' to leave program"
        program_choice = gets.strip.downcase

        if program_choice == 'exit'
          puts "Now exiting the program. See you later!"

        elsif program_choice.to_i <= NprStories::Program.all.size
          program = NprStories::Program.all[program_choice.to_i - 1] 
          @program_stories = NprStories::Scraper.new.scrape_stories(program) # create a new scraper & pull the stories for that program
          puts "Here are the recent stories from #{program.program_title}:"
          puts "----------------------------------------------------------------"
          @program_stories.each_with_index do |story, index|
            puts "#{index + 1}. #{story.story_title}"
          end #each_with_index loop
          puts "----------------------------------------------------------------"
          choose_story
        else
          puts "Sorry I didn't get that. Please try again."
        end #close if
      end # close until loop
  end

  def choose_story
    story_choice = nil
    until story_choice == 'exit'
      puts "Choose a story to see more details or go back to main menu with 'exit'"
      story_choice = gets.strip.downcase
      if story_choice == 'exit'
        puts "Now exiting back to the main menu..."

      elsif story_choice.to_i <= @program_stories.size 
        story = @program_stories[story_choice.to_i - 1]
        puts "#{story_choice}. #{story.story_title}"
        puts "Program: #{story.program_title}"
        puts "Date: #{story.story_date}"
        puts "Teaser: #{story.teaser}"
        puts "Url: #{story.story_url}"
        puts "----------------------------------------------------------------"

        puts "Would you like to read this story in the browser?"
        answer = gets.strip.downcase
        if answer.include?('y')
          system('open', "#{story.story_url}")
        end
      story_choice = nil 
      else
        puts "Sorry please try again."
      end # if loop
    end # until
  end 

end
