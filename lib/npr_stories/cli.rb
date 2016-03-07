class NprStories::CLI

  def call #starts up program win bin/npr_stories command in cli
    greeting
    list_programs
    choose_program
  end

  def greeting
    puts "Welcome to NPR!"
  end

  def exit_npr_stories
    puts "Now exiting the program. See you later!"
  end

  def list_programs
    puts <<-DOC
    Information on the following NPR programs is available.

      1.  All Things Considered
      2.  Ask Me Another
      3.  Fresh Air
      4.  Here and Now
      5.  Latino USA
      6.  Morning Edition
      7.  TED Radio Hour
      8.  Wait Wait ... Don't Tell Me!
      9.  Weekend Edition Saturday
      10. Weekend Edition Sunday

    DOC
  end

  def choose_program
    program_choice = nil
    until program_choice == 'exit'
      puts "Please select a show by number. Type 'menu' to see your options again, and 'exit' to leave the program."
      program_choice = gets.strip.downcase
        case program_choice
        when '1'
          program = ALL_THINGS_CONSIDERED
        when '2'
          program = ASK_ME_ANOTHER
        when '3'
          program = FRESH_AIR
        when '4'
          program = HERE_AND_NOW
        when '5'
          program = LATINO_USA
        when '6'
          program = MORNING_EDITION
        when '7'
          program = TED_RADIO_HOUR
        when '8'
          program = WAIT_WAIT
        when '9'
          program = WEEKEND_EDITION_SATURDAY
        when '10'
          program = WEEKEND_EDITION_SUNDAY
        when 'menu'
          list_programs
        when 'exit'
          exit_npr_stories
          #break
        else
          puts "Oops, that's not a valid command. Please try again."
        end

      if program_choice.to_i <= 10 && program_choice.to_i >= 1
        story_result = NprStories::Scraper.new(program).pull_stories  #story_result should be an array
        display_story(story_result)
      end
    end
  end

  def display_story(story_result)
      story_result.each_with_index do |story, index|
        puts "Story ##{index + 1}"
        puts "Story Title: #{story[:story_title]}"
        puts "Program: #{story[:program_title]}"
        puts "Date: #{story[:story_date]}"
        puts "Teaser: #{story[:teaser]}"
        puts "Url: #{story[:story_url]}"
        puts "Main Topic: #{story[:topic]}"
        puts "------------------------------"
      end
  end

end