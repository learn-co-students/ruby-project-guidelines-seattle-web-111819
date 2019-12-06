class CommandLine
    #ruby bin/run.rb

    def run
        CommandLine.welcome("clear")
    end 

    def self.exit_program
        system("clear")
        puts "Thanks for using Easy Music Calendar!"
    end 



    def self.welcome(clear=nil) 
        if clear 
          system("clear")
        end 
        puts "Welcome to Easy Music Calendar"
        puts ""
        puts "Select an option:"
        puts "--------------------"
        puts "1) Artist login"
        puts "2) Venue login"
        puts "3) Use as fan"
        puts "4) Create new profile"
        puts "5) Quit Easy Music Calendar"
        input = STDIN.gets.strip
           if input.to_i == 1 
              artist_login
            elsif input.to_i == 2 
                venue_login
            elsif input.to_i == 3 
                system("clear")
                fan_profile
           elsif input.to_i == 4 
              create_new_profile_menu
           elsif input.to_i == 5
            0
            exit_program
           else 
              system("clear")
              puts "Sorry, I don't understand your selection"
              puts "Please try again"
              puts "================"
              welcome
           end 
    end 

    def self.venue_login
        system("clear")
        puts "enter your username"
        puts "-----------------------"
        username = STDIN.gets.strip
        searched = search_venue_usernames(username)
        if searched != nil 
            venue_login_password(searched)
        else
            system("clear") 
            puts "I cannot find an artist with username: #{username}"
            puts "================="
            welcome
        end 
    end 

    def self.artist_login
        system("clear")
        puts "enter your username"
        puts "-----------------------"
        username = STDIN.gets.strip
        searched = search_artist_usernames(username)
        if searched != nil 
            artist_login_password(searched)
        else
            system("clear") 
            puts "I cannot find an artist with username: #{username}"
            puts "================="
            welcome
        end 
    end 

    def self.artist_login_password(artist)
        my_artist = artist 
        system("clear")
        puts "enter your password"
        puts "-----------------------"
        password = STDIN.gets.strip
        if password == my_artist.password 
           self.artist_welcome(my_artist)
        else
            system("clear")
            password_attempt(my_artist)
        end 
    end 

    def self.venue_login_password(venue)
        my_venue = venue
        system("clear")
        puts "enter your password"
        puts "-----------------------"
        password = STDIN.gets.strip
        if password == my_venue.password 
           self.venue_welcome(my_venue)
        else
            system("clear")
            password_attempt_v(my_venue)
        end 
    end 


    def password_attempt_v(venue)
        count = 4
        until count == 0 
            puts "incorrect password. You have #{count} more attempts"
            new_password = STDIN.gets.strip
            count -= 1
            if count == 2 || count == 1 || count == 3
                puts ""
                puts "Forgot password?"
                puts "password hint: #{user.password_hint}"
                puts ""
            end 
            if new_password == user.password
               CommandLine.venue_welcome(user)
               system("clear")
               count = 0 
            end 
        end 
        system("clear")
        puts "You have no more attempts"
        welcome
    end 

    def self.venue_welcome(venue)
        system("clear")
        puts "You have successfully logged in!"
        puts "================================"
        puts ""
        puts "Wecome #{venue.name}"
        puts ""
        puts "------------------------"
        venue_profile(venue)
    end 

    def self.venue_profile(venue)
        0
        puts "#{venue.name}'s Homepage"
        puts "==========================="
        puts "1) Update account settings"
        #puts "3) Look up event"
        puts "2) Logout"
        input = STDIN.gets.strip.to_i 
        if input == 1
            Venue.update_account(venue)
        elsif input == 2 
            system("clear")
            puts "You have successfully logged out!"
            puts ""
            welcome 
        else 
            "That is not a valid command"
            venue_profile(artist)
        end 
    end 

    

    
    
    #this may need work
    #need to see when end until loop 
    def self.password_attempt(user)
        count = 4
        until count == 0 
            puts "incorrect password. You have #{count} more attempts"
            new_password = STDIN.gets.strip
            count -= 1
            if count == 2 || count == 1 || count == 3
                puts ""
                puts "Forgot password?"
                puts "password hint: #{user.password_hint}"
                puts ""
            end 
            if new_password == user.password
               CommandLine.artist_welcome(user)
               system("clear")
               count = 0 
            end 
        end 
        system("clear")
        puts "You have no more attempts"
        welcome
    end 

    def self.artist_welcome(artist)
        system("clear")
        puts "You have successfully logged in!"
        puts "================================"
        puts ""
        puts "Wecome #{artist.name}"
        puts ""
        puts "------------------------"
        artist_profile(artist)
    end 

    def self.artist_profile(artist)
        puts "#{artist.name}'s Homepage"
        puts "==========================="
        puts "1) My events"
        puts "2) Update account settings"
        #puts "3) Look up event"
        puts "3) Logout"
        input = STDIN.gets.strip.to_i 
        if input == 1
            Artist.my_events_menu(artist)
        elsif input == 2
            Artist.update_artist_info_menu(artist)
            system("clear")
        elsif input == 3 
            system("clear")
            puts "You have successfully logged out!"
            puts ""
            welcome 
        else 
            "That is not a valid command"
            artist_profile(artist)
        end 
    end 

    def self.search_artist_usernames(username)
        Artist.find_by(username: username)
    end 

    def self.search_venue_usernames(username)
        Venue.find_by(username: username)
    end 

    def self.create_new_profile_menu
         system("clear")
         puts "Make a selection"
         puts "-------------------"
         puts ""
         puts "1) Create new artist profile"
         puts "2) Create new venue profile"
         puts "3) return to main menu"
         input = STDIN.gets.strip.to_i 
         if input == 1
            system("clear")
            create_new_artist
         elsif input == 2
            create_new_venue
         elsif input == 3
             self.welcome
         else 
        system("clear")
        puts "Invalid command"
        puts "Please try again"
        create_new_profile_menu
    end
end 

def self.create_new_artist_second
    system("clear")
    puts "Make a selection"
    puts "---------------------"
    puts""
    puts "1) Try again"
    puts "2) Return to main menu "
    input = STDIN.gets.strip.to_i
    if input == 1
        create_new_artist
    elsif input == 2
        system("clear")
        welcome
    else puts "invalid command"
        create_new_artist_second
    end 
end 

def self.create_new_artist
    puts "enter a new username"
    new_username = STDIN.gets.strip
    if check_artist_username(new_username).exists? 
        puts "Sorry this username has already been taken"
        create_new_artist_second 
    else 
    puts ""
    puts "Enter artist name"
    puts ""
    new_name = STDIN.gets.strip
    puts ""
    puts "What is your genre"
    puts ""
    new_genre = STDIN.gets.strip
    puts ""
    puts "Enter your password"
    puts ""
    new_password = STDIN.gets.strip
    puts ""
    puts "Enter password hint"
    puts ""
    new_password_hint = STDIN.gets.strip
    new_artist = Artist.create(name: "#{new_name}" , genre: "#{new_genre}", password: "#{new_password}", password_hint: "#{new_password_hint}", username: "#{new_username}")
    system("clear")
    self.artist_profile(new_artist)
    end 
end 

def self.create_new_venue_second
    system("clear")
    puts "Make a selection"
    puts "---------------------"
    puts""
    puts "1) Try again"
    puts "2) Return to main menu "
    input = STDIN.gets.strip.to_i
    if input == 1
        create_new_venue
    elsif input == 2
        system("clear")
        welcome
    else puts "invalid command"
        create_new_venue_second
    end 
end 

def self.create_new_venue
    puts "enter a new username"
    new_username = STDIN.gets.strip
    if check_venue_username(new_username).exists? 
        puts "Sorry this username has already been taken"
        create_new_venue_second 
    else 
    puts ""
    puts "Enter venue name"
    puts ""
    new_name = STDIN.gets.strip
    puts ""
    puts "Enter your password"
    puts ""
    new_password = STDIN.gets.strip
    puts ""
    puts "Enter password hint"
    puts ""
    new_password_hint = STDIN.gets.strip
    puts "What is your street address"
    puts ""
    new_street_address = STDIN.gets.strip
    puts ""
    puts "Enter your city"
    puts ""
    new_city = STDIN.gets.strip
    puts ""
    puts "Enter zip code"
    puts ""
    new_zip_code = STDIN.gets.strip
    puts "Enter the venue capacity"
    puts ""
    new_capacity = STDIN.gets.strip
    new_venue = Venue.create(name: "#{new_name}" , street_address: "#{new_street_address}", password: "#{new_password}", password_hint: "#{new_password_hint}", username: "#{new_username}", city: "#{new_city}", zip_code: "#{new_zip_code}", capacity: "#{new_capacity}")
    system("clear")
    self.venue_profile(new_venue)
    end 
end 

def self.check_venue_username(username)
    Venue.where(username: username)
end 

def self.check_artist_username(username)
    Artist.where(username: username)
end 
def self.venue_ask
    puts "Enter a venue name"
    input = STDIN.gets.strip
    inp = input.titleize 
    v = Venue.find_by(name: inp)
    if v == nil 
        puts "cannot find that venue"
        self.fan_profile
    else 
    e = Event.where(venue_id: v.id)
    view_all_events_2(e)
    end 
end 
  
def self.display_venues(v)
    puts "- Name :#{v.name}"
    puts "- Street address:#{v.street_address}"
    puts "- City: #{v.city}"
    puts "- Zipcode:#{v.zip_code}"
    puts "- Capacity: #{v.capacity}"
    self.fan_profile
end 

def self.artist_ask
    puts "Enter an artist name"
    input = STDIN.gets.strip
    inp = input.titleize 
    a = Artist.find_by(name: inp)
    if a == nil 
        puts "cannot find that artist"
        self.fan_profile
    else 
    e = Event.where(artist_id: a.id)
    view_all_events_2(e)
    end 
end 

def self.display_artist(a)
    puts "- Name :#{a.name}"
    puts "- Genre:#{a.genre}"
    self.fan_profile
end 

def self.view_all_artists
    Artist.all.each do |a|
        puts ""
        puts "- #{a.name}"
    end 
    puts " enter any key"
    input = STDIN.gets.strip
    self.fan_profile
end 

def self.view_all_venues
    Venue.all.each do |v|
        puts ""
        puts ""
        puts "- Name :#{v.name}"
        puts "----------------------------------"
    puts "- Street address:#{v.street_address}"
    puts "- City: #{v.city}"
    puts "- Zipcode:#{v.zip_code}"
    puts "- Capacity: #{v.capacity}"
    end 
    puts " enter any key"
    input = STDIN.gets.strip
    system("clear")
    self.fan_profile
end 

def self.view_all_events_2(event)
    if events = []
        puts "No events"
    else
    event.all.each do |e|
        v = Venue.find(e.venue_id)
        a = Artist.find(e.artist_id)
        puts ""
        puts "================================="
        puts "- Artist: #{a.name}"
        puts "- Genre: #{a.genre}"
        puts "---------------------------------"
        puts "- Date: #{e.date} (yyyy-mm-dd)"
        puts "- Venue :#{v.name}"
        puts "---------------------------------"
        puts "- Street address:#{v.street_address}"
        puts "- City: #{v.city}"
        puts "- Zipcode: #{v.zip_code}"
        puts "- Capacity: #{v.capacity}"
    end 
    end 
    puts " enter any key"
    input = STDIN.gets.strip
    system("clear")
    self.fan_profile
end 


def self.fan_profile
    puts "Welcome"
    puts "1) View all events at a venue"
    puts "2) View all events for artist"
    puts "3) View all artists"
    puts "4) View all venues"
    puts "5) Return to start"
    input = STDIN.gets.strip.to_i
    if input == 1
        system("clear")
        CommandLine.venue_ask
    elsif input == 2
        system("clear")
        artist_ask
    elsif input == 3
        system("clear")
        view_all_artists
    elsif input == 4
        system("clear")
        view_all_venues
    elsif input == 5
        system("clear")
        self.welcome
    else 
        system("clear")
        puts "Invalid Command"
        self.fan_profile
    end 
    
end 


 end 



