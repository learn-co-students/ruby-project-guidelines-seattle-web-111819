class Artist < ActiveRecord::Base
    has_many :events
    has_many :venues, through: :events 

    def list_of_venues
        system("clear")
        puts "Would you like a list of venues to choose from?"
        puts "1) Yes"
        puts "2) No"
        input = STDIN.gets.strip.to_i 
        if input == 1 
            Venue.venue_names 
        elsif input == 2 
        else puts "Not a valid answer"
            list_of_venues
        end 
    end 

    def create_new_event
        system("clear")
        list_of_venues
        puts "Where will you be performing?"
        venue_name = STDIN.gets.strip
        v = Venue.find_a_venue(venue_name)
        cli = CommandLine.new
        date = cli.day_of_event
        new_event = Event.create(artist_id: self.id, venue_id: v.id, date: date) 
        new_event
    end 

    def all_events
        Event.where(artist_id: self.id)
    end 

    def update_artist
        system("clear")
        puts "Would you like to..."
        puts "1)Update artist name"
        puts "2)update artist genre"
        input = STDIN.gets.strip.to_i
        if input == 1 
            update_artist_name
        elsif input == 2
            update_artist_genre
        else puts "Sorry, I don't understand your selection"
            puts "Please try again"
            update_artist
        end 
    end 

    def update_artist_name
        system("clear")
        puts "your current name is #{self.name}"
        puts "Enter a new artist name"
        input = STDIN.gets.strip
        self.name = input
        self.save 
        puts "Your new artist name is '#{self.name}'"
        anything_else
    end 

    def update_artist_genre
        system("clear")
        puts "your current genre is #{self.genre}"
        puts "Enter a new genre"
        input = STDIN.gets.strip
        self.genre = input 
        self.save 
        puts "Your new artist name is '#{self.genre}'"
        anything_else
    end 

    def delete_artist
        system("clear")
        puts "deleting you profile will permanently delete all your information"
        puts "Are You sure you want to delete your artist profile?"
        puts "1) Yes, delete my profile"
        puts "2) No, do not delete my profile"
        input = STDIN.gets.strip
        if input.to_i == 1
            self.destroy 
        elsif input.to_i == 2
            band_profile
        else 
            puts "Sorry. That is not a valid command" 
            delete_artist
        end 
    end 

    def pretty_print_all_events
        system("clear")
        my_events = Event.where(artist_id: self.id)
        pretty_print_events(my_events)
    end 

    def pretty_print_events(event_array)
        system("clear")
        if event_array.count == 0 
            puts "===================="
            puts "You have no events"
        else  
           i = 0 
           puts "My events"
           puts "===================="
           event_array.each do |event| 
                v_id = event.venue_id 
                e_venue = Venue.find(v_id)
                venue_name = e_venue.name 
                e_date = event.date 
                puts "Event ##{i += 1}"
                puts " "
                puts "Where: #{venue_name}"
                puts "When: #{e_date}"
                puts "--------------------"
            end 
        end 
        anything_else 
    end 

    def anything_else
        puts "===================="
        puts "1) Return to profile"
        puts "2) Return to my events" 
        puts "3) Return to top menu" 
        puts "===================="
        input = STDIN.gets.strip
        if input.to_i == 1
            band_profile
        elsif input.to_i == 2
            view_my_events
        elsif input.to_i == 3 
            cli = CommandLine.new
            cli.run 
        elsif input == "exit"
            cli = CommandLine.new
            cli.exit_program 
        else puts "Sorry, I don't understand your selection"
            puts "Please try again"
            anything_else
        end
    end 

    def past_events
        current_year = Time.now.year
        current_day = Time.now.day
        current_month =  Time.now.month
        past_events = []
        all_events.each do |event| 
            date_array = event.date.split(/-/)
            event_year = date_array[0].to_i
            event_month = date_array[1].to_i
            event_day = date_array[2].to_i 
            if event_year < current_year 
               past_events << event 
            elsif 
               event_year == current_year && event_month < current_month
               past_events << event 
            elsif 
                event_year == current_year && event_month == current_month && event_day < current_day
                past_events << event 
            end 
        end 
        pretty_print_events(past_events)
    end 

    def upcoming_events
        current_year = Time.now.year
        current_day = Time.now.day
        current_month =  Time.now.month
        future_events = []
        all_events.each do |event| 
            date_array = event.date.split(/-/)
            event_year = date_array[0].to_i
            event_month = date_array[1].to_i
            event_day = date_array[2].to_i 
            if event_year > current_year 
               future_events << event 
            elsif 
               event_year == current_year && event_month > current_month
               future_events << event 
            elsif 
                event_year == current_year && event_month == current_month && event_day >= current_day
                future_events << event 
            end 
        end 
        pretty_print_events(future_events)
    end 

    def band_profile 
        puts "===================="
        puts "Welcome #{self.name}"
        puts "===================="
        puts "Select an option"
        puts "--------------------"
        puts "1) View my events"
        puts "2) Create new event"
        puts "3) Delete my artist profile"
        puts "4) Update artist information"
        puts "5) Return to top menu" 
        input = STDIN.gets.strip
        if input.to_i == 1
            view_my_events
        elsif input.to_i == 2 
            create_new_event
        elsif input.to_i == 3
            delete_artist
        elsif input.to_i == 4 
            update_artist
        elsif input.to_i == 5 
            cli = CommandLine.new
            cli.run 
        end 
    end 

    def view_my_events
        puts "Select an option"
        puts "1) View all events"
        puts "2) View upcoming events"
        puts "3) View past events"
        puts "4) Return to my profile"
        puts "5) Return to top menu" 
        input = STDIN.gets.strip
        if input.to_i == 1
            self.pretty_print_all_events
        elsif input.to_i == 2
            self.upcoming_events
        elsif input.to_i == 3 
            self.past_events
        elsif input.to_i == 4 
            self.band_profile
        elsif input.to_i == 5 
            cli = CommandLine.new
            cli.run 
        end 
    end 


    def self.find_an_artist(artist_name)
        my_profile = Artist.find_by(name: artist_name)
        if my_profile != nil 
            my_profile
        else
            cap_first_letters = artist_name.split.map(&:capitalize).join(' ')
            my_profile = Artist.find_by(name: cap_first_letters)
            if my_profile != nil 
                my_profile
            else
            puts "I couldn't find an Artist with that name."
            puts "1) Try again"
            puts "2) Return to top menu"
            puts "3) Create new Artist profile"
            input_2 = gets.strip  
                if input_2.to_i == 1
                   Artist.find_an_artist 
                elsif 
                   input_2.to_i == 2
                   welcome 
                elsif
                   input_2.to_i == 3 
                   Artist.create_new_artist
                else puts "Sorry, I don't understand your selection"
                    puts "Please try again"
                    Artist.find_an_artist
                end 
            end 
        end 
    end 

    def self.artist_welcome
        system("clear")
        puts "Would you like to:"
        puts "1) Create new artist"
        puts "2) Use as existing artist"
        puts "3) Go back to top menu"
        input = gets.strip 
        if input.to_i == 1 || input.downcase == "create new artist"
            create_new_artist
        elsif input.to_i == 2 || input.downcase == "use as existing artist"
            use_existing_artist
        elsif input.to_i == 3 || input.downcase == "go back to top menu"
            cli = CommandLine.new
            cli.run 
        else puts "Sorry, I don't understand your selection"
             puts "Please try again"
             self.artist_welcome
        end 
    end 

    def self.create_new_artist
        puts "enter your artist name"
        name = gets.strip
        puts "enter your genre"
        genre = gets.strip
        new_artist = Artist.create(name: name, genre: genre)
        new_artist.band_profile
    end 

    def self.use_existing_artist
        puts "--------------------"
        puts "Enter the artist name" 
        puts "--------------------"
        artist_name = gets.strip
        my_artist = Artist.find_an_artist(artist_name)
        my_artist.band_profile
    end 



end 

#system("clear")
