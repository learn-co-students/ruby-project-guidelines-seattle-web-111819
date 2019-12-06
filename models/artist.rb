class Artist < ActiveRecord::Base
    has_many :events
    has_many :venues, through: :events


    def print_all_events
        artist_events = self.all_events 
        #art_events.pretty_print_all_events
        pretty_print_events(artist_events)
    end 

    def self.my_events_menu(artist)
        system("clear")
        art = artist 
        puts "Event Menu"
        puts "====================="
        puts "1) View all events"
        puts "2) View upcoming events"
        puts "3) View past events"
        puts "4) Find event"
        puts "5) Update an event"
        puts "6) Create an event"
        puts "7) View all events by venue"
        puts "8) Return to #{artist.name}'s homepage"
        input = STDIN.gets.strip.to_i 
        if input == 1
            art.print_all_events
        elsif input == 2
            art.print_upcoming_events
        elsif input == 3
            art.print_past_events
        elsif input == 4 
            art.event_info_trouble
            system("clear")
        elsif input == 5 
            art.update_event
        elsif input == 6 
            art.create_event 
        elsif input == 7 
            system("clear")
            art.find_event_by_venue 
        elsif input == 8 
            system("clear")
            CommandLine.artist_profile(artist)
        else
            system("clear")
            puts "Invalid Command"
            self.my_events_menu(artist)
        end 
    end 

    def find_event_by_venue
        puts "enter venue name"
        input = STDIN.gets.strip
        v = input.titleize 
        my_v = Venue.find_by(name: v)
        if my_v == nil 
            puts "No events at the venue"
            anything_else
        else 
        e = Event.where(artist_id: self.id, venue_id: my_v.id)
        pretty_print_events(e)
        end 
    end 

   


    def create_event 
        puts "Create New Event"
        puts "=================="
        puts ""
        date = ask_date
        v = ask_venue 
        #binding.pry 
        event = Event.create(date: date, venue_id: v.id, artist_id: self.id)
        puts "You have created a new event"
        puts "============================="
        print_event_info_troubleshoot(event)
    end 

    def ask_date
        puts "Enter your event date: (mm-dd-yyyy)"
        puts "------------------------------------"
        puts ""
        date = STDIN.gets.strip 
        format_date(date)
    end 

    ###
    def ask_venue
        puts "Make a Selection"
        puts "====================="
        puts "1) Enter venue name"
        puts "2) List all participating venues"
        input = STDIN.gets.strip.to_i
        if input == 1
            venue = STDIN.gets.strip
            v = search_for_venue_by_name(venue)
        elsif input == 2
            puts "Choose a venue from the list below by typing the name"
            list__all_venues
            venue = STDIN.gets.strip
            v = search_for_venue_by_name(venue) 
        else 
        Artist.my_events_menu(self)
        end 
        v 
    end 

    def list__all_venues
        Venue.all.each do |v|
            puts "- #{v.name}"
        end 
    end 

    def event_info
        located = locate_event
        print_event_info(located) 
    end 

    def event_info_trouble
        located = locate_event
        print_event_info_troubleshoot(located) 
    end 

    def print_event_info(event)
        e = event[0] 
        event_venue = Venue.find(e.venue_id)
        event_artist = Artist.find(e.artist_id)
        system("clear")
        puts "My event"
        puts "==========================="
        puts ""
        puts "Venue: #{event_venue.name}"
        puts "Date: #{e.date}"
        puts "Artist: #{event_artist.name}"
        puts ""
        display_venue_info(event_venue)
        anything_else
    end 

    def print_event_info_troubleshoot(event)
        e = event
        event_venue = Venue.find(e.venue_id)
        event_artist = Artist.find(e.artist_id)
        system("clear")
        puts "My event"
        puts "==========================="
        puts ""
        puts "Venue: #{event_venue.name}"
        puts "Date: #{e.date}"
        puts "Artist: #{event_artist.name}"
        puts ""
        display_venue_info(event_venue)
        anything_else
    end 


    def display_venue_info(venue)
        v = venue
        puts ""
        puts "Venue information"
        puts "==========================="
        puts ""
        puts "Venue: #{v.name}"
        puts "Address: #{v.street_address}"
        puts "Zip code #{v.zip_code}"
        puts "City: #{v.city}"
        puts "Capacity: #{v.capacity}"
    end 

    def update_event
        e = locate_event
        puts "Update event"
        puts "================="
        puts ""
        puts "1) Change venue"
        #puts "2) Change date"
        puts "2) Return to artist homepage"
        input = STDIN.gets.strip.to_i
        if input == 1
            update_event_venue(e)
        # elsif input == 2
        #     update_event_date(e)
        elsif input == 2
            Artist.my_events_menu 
        else 
            system("clear")
            puts "Invalid Command"
            update_event
        end 
    end 

    def update_event_venue(event)
        e = event
        puts "Enter new venue name"
        new_venue = STDIN.gets.strip
        searched = search_for_venue_by_name(new_venue)
        if searched != nil 
            e.venue_id = searched.id 
            e.save 
            puts "Successful!"
            CommandLine.artist_profile(self)
        else 
            system("clear")
            puts "There is no venue with that name"
            update_event_venue_second(event)
        end 
    end 

    def update_event_venue_second(event)
        puts "1) try again"
        puts "2) return to homepage"
        input = STDIN.gets.strip.to_i
        if input == 1
            update_event_venue(event)
        elsif input == 2
            CommandLine.artist_profile(self)
        else
            system("clear")
            puts "Invalid Command"
            update_event_venue_second(event)
        end 
    end 
    
    ####
    def update_event_date(event)
    end 

    def search_for_venue_by_name(venue_name)
        v = venue_name.titleize 
        my_venue = Venue.find_by(name: v)
        if my_venue == nil 
            not_a_venue_message
        end 
        my_venue
    end 

    def not_a_venue_message
        puts "I'm sorry. There is no venue with that name"
        ask_venue
    end 

    def all_events_by_venue(venue)
        v = venue 
        v_events = Event.where(venue_id: v.id, artist_id: self.id)
        print_event_info(v_events)
    end 

    def locate_event_by_date
        system("clear")
        puts "Event search"
        puts "-------------------"
        puts ""
        puts "Enter event date: (mm-dd-yyyy)"
        date = STDIN.gets.strip
        form_date = format_date(date)
    end 


    def locate_event_by_venue(date)
        puts "-----------------------"
        puts ""
        puts "1) Search venue name"
        puts "2) Browse by venue"
        puts "3) Return to my homepage"
        puts ""
        input = STDIN.gets.strip.to_i
        if input == 1
            system("clear")
            puts "Enter venue name"
            puts "-------------------"
            puts ""
            venue = STDIN.gets.strip
            v = venue.titleize
            #binding.pry
            find_v = Venue.find_by(name: v)
            if find_v == nil 
                puts "Not a valid venue"
               locate_event_by_venue(date)
            else 
                find_an_event(date, find_v)
            end 
        elsif input == 2
            venues_played
            puts "===================="
            puts "Enter venue name"
            puts ""
            venue = STDIN.gets.strip
            v = venue.titleize
            find_v = Venue.find_by(name: v)
            if find_v == nil 
               puts "Not a valid venue"
               locate_event_by_venue(date)
            else
               find_an_event(date, find_v)
            end 
        elsif input == 3
            system("clear")
            CommandLine.artist_profile(self)
        else 
            system("clear")
            puts "Invalid Command"
            locate_event
        end 
    end 

    def locate_event
        date = locate_event_by_date
        event = locate_event_by_venue(date)  
        #binding.pry
        if event != nil 
           event
        #print_event_info(event)
        else 
            puts "There is no record of that event"
            puts "press any key to continue"
            input = STDIN.gets.strip
            Artist.my_events_menu(self)
        end 
    end 

    def find_an_event(date, venue)
        #binding.pry 
        v = venue 
        e = Event.find_by(date: date, venue_id: v.id)
        if e == []
            puts "Could not find that event"
            anything_else
        end 
        e 
    end 

    #this lists the venues by name that ive played do alphbetical if you can 
    def venues_played 
        system("clear")
        puts "--------------------"
        puts "Venues I've played"
        puts "--------------------"
        puts ""
        artist_events = self.all_events 
        artist_events.each do |e|
            v_id = e.venue_id
            my_venue = Venue.find(v_id)
            name = my_venue.name 
            puts "- #{name}"
        end 
    end 

    def format_date(date)
        unformated_date = date 
        split_date = unformated_date.split(/-/)
        month = split_date[0]
        day = split_date[1]
        year = split_date[2]
        checked = check_date(month, day, year)
        date = "#{year.to_i}-#{month.to_i}-#{day.to_i}" 
    end 

    def check_date(month, day, year) 
        if month == nil 
            puts "Not a valid date. Please try again"
            create_event
            
        elsif day == nil 
            puts "Not a valid date. Please try again"
            create_event
            
        elsif year == nil 
            puts "Not a valid date. Please try again"
            create_event
            
        end 
        if (month.to_i.is_a? Integer) == false || month.to_i > 12 || month.to_i < 1
            sorry_message("date")
        elsif (day.to_i.is_a? Integer) == false || day.to_i > 31 || day.to_i < 1  
            sorry_message("date")
        elsif (year.to_i.is_a? Integer) == false  || year.size != 4
            sorry_message("date")
        end 
    end 

    def sorry_message(type)
        system("clear")
        puts "That is not a valid #{type}."
        #anything_else
        create_event
    end 

    def print_upcoming_events 
        artist_events = self.all_events
        upcoming_events(artist_events)
    end 

    def print_past_events 
        artist_events = self.all_events
        past_events(artist_events)
    end 


    def all_events
        Event.where(artist_id: self.id)
    end 

    def pretty_print_events(events)
        system("clear")
        if events.count == 0 
            puts "===================="
            puts "You have no events"
        else  
           i = 0 
           puts "My events"
           puts "===================="
           events.each do |event| 
                v_id = event.venue_id 
                e_venue = Venue.find(v_id)
                venue_name = e_venue.name 
                e_date = event.date 
                puts "Event ##{i += 1}"
                puts " "
                puts "Where: #{venue_name}"
                puts "When: #{e_date} (yyyy-mm-dd)"
                puts "--------------------"
            end 
        end 
        anything_else 
    end 

    def past_events(artist_events)
        my_events = artist_events 
        current_year = Time.now.year
        current_day = Time.now.day
        current_month =  Time.now.month
        past_events = []
        my_events.each do |event| 
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

    def upcoming_events(artist_events)
        my_events = artist_events 
        current_year = Time.now.year
        current_day = Time.now.day
        current_month =  Time.now.month
        future_events = []
        my_events.each do |event| 
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

    def self.update_artist_info_menu(artist)
        system("clear")
        art = artist 
        puts "1) Change username"
        puts "2) Change Artist name"
        puts "3) Change password"
        puts "4) Change password hint"
        puts "5) Update genre"
        puts "6) Return to #{artist.name}'s homepage'"
        input = STDIN.gets.strip.to_i
        if input == 1 || input == 2 || input == 3 || input == 4 || input == 5
            art.update_info(input)
        elsif input == 6
            system("clear")
            CommandLine.artist_profile(artist)
        else 
            system("clear")
            puts "Invalid command"
            art.update_artist_info_menu
        end 
    end 

    def update_info(input)
        if input == 1
            att = "username"
            att_value = self.username 
        elsif input == 2
            att = "Artist name"
            att_value = self.name 
        elsif input == 3
            att = "password"
            att_value = self.password
        elsif input == 4
            att = "password hint"
            att_value = self.password_hint
        elsif input == 5
            att = "genre"
            att_value = self.genre 
        end 
        puts "Your current #{att} is: #{att_value}"
        puts "enter new #{att}"
        input_2 = STDIN.gets.strip
        if  input == 1 
            self.username = input_2
            self.save 
        elsif input == 2 
            self.name = input_2
            self.save 
        elsif input == 3 
            self.password = input_2
            self.save 
        elsif input == 4 
            self.password_hint = input_2
            self.save 
        elsif input == 5 
            self.genre = input_2
            self.save  
        end 
        system("clear")
        puts "Your #{att} has been successfully updated to #{input_2}"
        CommandLine.artist_profile(self)
    end 

    def anything_else
        puts "===================="
        puts "1) Return to profile"
        puts "2) Return to my events" 
        puts "===================="
        input = STDIN.gets.strip
        system("clear")
        if input.to_i == 1
            CommandLine.artist_profile(self)
        elsif input.to_i == 2
            Artist.my_events_menu(self)
        else puts "Sorry, I don't understand your selection"
            puts "Please try again"
            anything_else
        end
    end 

end 

