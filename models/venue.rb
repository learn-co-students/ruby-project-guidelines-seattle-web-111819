class Venue < ActiveRecord::Base
    has_many :events 
    has_many :artists, through: :events 

    def self.update_account(venue)
        v = venue 
        puts "1) Update username"
        puts "2) Update name"
        puts "3) Update password"
        puts "4) Update password hint"
        puts "5) Update street address"
        puts "6) Update city"
        puts "7) Update zipcode"
        puts "8) Venue info"
        puts "9) Return to Homepage"
        input = STDIN.gets.strip.to_i
        update_info(input, v)
    end 

    def self.update_info(input, v)
        if input == 1
            att = "username"
            att_value = v.username
            up_next(input, v, att, att_value) 
        elsif input == 2
            att = "Venue name"
            att_value = v.name 
            up_next(input, v, att, att_value)
        elsif input == 3
            att = "password"
            att_value = v.password
            up_next(input, v, att, att_value)
        elsif input == 4
            att = "password hint"
            att_value = v.password_hint
            up_next(input, v, att, att_value)
        elsif input == 5
            att = "street adresss"
            att_value = v.street_address
            up_next(input, v, att, att_value)
        elsif input == 6
            att = "City"
            att_value = v.city
            up_next(input, v, att, att_value)
        elsif input == 7
            att = "Zip code"
            att_value = v.zip_code
            up_next(input, v, att, att_value)
        elsif input == 8
            venue_information(v)
            up_next(input, v, att, att_value)
        elsif input == 9
            CommandLine.venue_profile(v)
        else 
            system("clear")
            puts "Invalid Command"
            update_account(v)
        end 

    end 

    def self.up_next(input, v, att, att_value)
        puts "Your current #{att} is: #{att_value}"
        puts "enter new #{att}"
        input_2 = STDIN.gets.strip
        if  input == 1 
            v.username = input_2
            v.save 
        elsif input == 2 
            v.name = input_2
            v.save 
        elsif input == 3 
            v.password = input_2
            v.save 
        elsif input == 4 
            v.password_hint = input_2
            v.save 
        elsif input == 5 
            v.street_address = input_2
            v.save  
        elsif input == 6 
            v.city = input_2
            v.save  
        elsif input == 7 
            v.zipcode = input_2
            v.save 
        end 
        system("clear")
        puts "Your #{att} has been successfully updated to #{input_2}" 
        CommandLine.venue_profile(v)
    end 

    def self.venue_information(v)
        system("clear")
        puts ""
        puts "- username: #{v.username}"
        puts "- street address: #{v.street_address}"
        puts "- city: #{v.city}"
        puts "- zip code: #{v.zip_code}"
        puts "- capacity: #{v.capacity}"
        puts ""
        puts "Enter any key to return"
        input = STDIN.gets.strip
        Venue.update_account(v)
    end 

    # def create_new_event(artist, date)
    #     art = Artist.find_by(name: artist)
    #     new_event = Event.create(artist_id: art.id, venue_id: self.id, date: date)
    #     new_event
    # end 

    # def all_events
    #     Event.where(venue_id: self.id)
    # end 

    # def upcoming_events
    #     current_year = Time.now.year
    #     current_day = Time.now.day
    #     current_month =  Time.now.month
    #     future_events = []
    #     self.all_events.each do |event| 
    #         date_array = event.date.split(/-/)
    #         event_year = date_array[0].to_i
    #         event_month = date_array[1].to_i
    #         event_day = date_array[2].to_i 
    #         if event_year > current_year 
    #            future_events << event 
    #         elsif 
    #            event_year == current_year && event_month > current_month
    #            future_events << event 
    #         elsif 
    #             event_year == current_year && event_month == current_month && event_day >= current_day
    #             future_events << event 
    #         end 
    #     end 
    #     future_events
    # end 

    # def past_events
    #     current_year = Time.now.year
    #     current_day = Time.now.day
    #     current_month =  Time.now.month
    #     past_events = []
    #     self.all_events.each do |event| 
    #         date_array = event.date.split(/-/)
    #         event_year = date_array[0].to_i
    #         event_month = date_array[1].to_i
    #         event_day = date_array[2].to_i 
    #         if event_year < current_year 
    #            past_events << event 
    #         elsif 
    #            event_year == current_year && event_month < current_month
    #            past_events << event 
    #         elsif 
    #             event_year == current_year && event_month == current_month && event_day < current_day
    #             past_events << event 
    #         end 
    #     end 
    #     past_events
    # end 

    # def self.make_new_profile(name, street_address, city, zip_code, capacity)
    #     new_venue = Venue.create(name: name, street_address: street_address, city: city, zip_code: zip_code, capacity: capacity)
    #     new_venue 
    # end 

    # def venue_profile
    #     puts "Welcome #{self.name}"
    #     puts"Select an option"
    #     puts "1) View all my events"
    #     puts "2) View upcoming events"
    #     puts "3) View past events"
    #     puts "4) Create new event"
    #     puts "5) View artists that have played here"
    #     puts "6) When is my next event and who will be performing?"    
    # end 

    # def self.find_a_venue(venue_name)
    #     my_profile = Venue.find_by(name: venue_name)
    #     if my_profile != nil 
    #         my_profile
    #     else
    #         cap_first_letters = venue_name.split.map(&:capitalize).join(' ')
    #         my_profile = Venue.find_by(name: cap_first_letters)
    #         if my_profile != nil 
    #             my_profile
    #         else
    #         puts "I couldn't find an venue with that name."
    #         puts "1) Try again"
    #         puts "2) Return to top menu"
    #         puts "3) Create new venue profile"
    #         puts "4) list all venues by name"
    #         input_2 = gets.strip  
    #             if input_2.to_i == 1
    #                Venue.find_a_venue(venue_name) 
    #             elsif 
    #                input_2.to_i == 2
    #                cli = CommandLine.new
    #                cli.run 
    #             elsif
    #                input_2.to_i == 3 
    #                Venue.create_new_venue
    #             elsif
    #                 input_2.to_i == 4 
    #                 Venue.venue_names
    #                 #Venue.find_a_venue(venue_name)
    #             else puts "Sorry, I don't understand your selection"
    #                 puts "Please try again"
    #                 self.venue_welcome
    #             end 
    #         end 
    #     end 
    # end 

    # def venue_profile
    #     puts "Welcome #{self.name}"
    #     puts "Select an option"
    #     puts "1) View my events"
    #     puts "2) Create new event"
    #     puts "3) View artists that have played at #{self.name}"
    #     puts "4) When and who is playing my next show?"
    #     puts "5) Return to top menu" 
    #     input = STDIN.gets.strip
    #     if input.to_i == 1
    #         view_my_events
    #     elsif input.to_i == 2 
    #         create_new_event
    #     elsif input.to_i == 3

    #     elsif input.to_i == 4 

    #     elsif input.to_i == 5 
    #         cli = CommandLine.new
    #         cli.run 
    #     end 
    # end 

    # def self.create_new_venue
    #     puts "Enter a venue name"
    #     name = gets.strip
    #     puts = "What city is #{name} in?"
    #     city = gets.strip
    #     puts "what is the zip code?"
    #     zip_code = gets.strip 
    #     puts "What is street address"
    #     street_address = gets.strip
    #     puts "what is #{name}'s capacity"
    #     new_artist = Artist.create(name: name, street_address: street_address, city: city, zip_code: zip_code, capacity: capacity)
    #     new_artist.venue_profile 
    # end 

    # def view_my_events
    #     puts "Select an option"
    #     puts "1) View all events"
    #     puts "2) View upcoming events"
    #     puts "3) View past events"
    #     puts "4) Return to my profile"
    #     puts "5) Return to top menu" 
    #     input = STDIN.gets.strip
    #     if input.to_i == 1
    #         self.all_events
    #     elsif input.to_i == 2
    #         self.upcoming_events
    #     elsif input.to_i == 3 
    #         self.past_events
    #     elsif input.to_i == 4 
    #         self.venue_profile
    #     elsif input.to_i == 5 
    #         cli = CommandLine.new
    #         cli.run 
    #     end 
    # end 

    # def pretty_print_events(event_array)
    #     i = 0 
    #     puts "My events"
    #     event_array.each do |event| 
    #         a_id = event.artist_id 
    #         e_artist = Artist.find(a_id)
    #         artist_name = e_artist.name 
    #         e_date = event.date 
    #         puts "Event ##{i += 1}"
    #         puts "Where: #{artist_name}"
    #         puts "When: #{e_date}"
    #     end 
    #     anything_else 
    # end 

    # def anything_else
    #     puts "Return to profile"
    #     puts "Return to my events" 
    #     puts "Return to top menu" 
    #     input = STDIN.gets.strip
    #     if input.to_i == 1
    #         venue_profile
    #     elsif input.to_i == 2
    #         view_my_events
    #     elsif input.to_i == 3 
    #         cli = CommandLine.new
    #         cli.run 
    #     end
    # end 

    # def self.venue_names
    #     Venue.all.map{|venue| puts "- #{venue.name}"}
    #     puts "==================="

        # puts "Would you like to try again"
        # puts "1) Yes, try again"
        # puts "2) No, return to profile"
        # input = STDIN.gets.strip
        # loop do 
        #     input != 1 && input != 2
        #     puts "Sorry, I don't understand your selection"
        #     puts "Please try again"
        #     self.venue_names
        #     input != 1 && input != 2
        # until input == 1 
        #     self.venue_name
        # elsif input == 2
        # else  
        #     input == 1 || input == 2
        #     puts "Sorry, I don't understand your selection"
        #     puts "Please try again"
        #     self.venue_names
        # end 
 
    #end 

    # def self.venue_welcome
    #     puts "Would you like to:"
    #     puts "1) Create new venue"
    #     puts "2) Use as existing venue"
    #     puts "3) Go back to top menu"
    #     input = gets.strip 
    #     if input.to_i == 1 || input.downcase == "create new venue"
    #         create_new_venue
    #     elsif input.to_i == 2 || input.downcase == "use as existing venue"
    #         use_existing_venue
    #     elsif input.to_i == 3 || input.downcase == "go back to top menu"
    #         welcome
    #     else puts "Sorry, I don't understand your selection"
    #          puts "Please try again"
    #          self.venue_welcome
    #     end 
    # end 

    # def self.use_existing_venue
    #     puts "enter the venue name" 
    #     venue_name = gets.strip
    #     my_venue = Venue.find_a_venue(venue_name)
    #     my_venue.venue_profile
    # end 

end 