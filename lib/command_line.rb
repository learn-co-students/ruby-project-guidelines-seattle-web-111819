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
        puts "2) Create new profile"
        puts "3) Quit Easy Music Calendar"
        input = STDIN.gets.strip
           if input.to_i == 1 
              artist_login
           elsif input.to_i == 2 
              create_new_profile_menu
           elsif input.to_i == 3
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
    
    #this may need work
    #need to see when end until loop 
    def self.password_attempt(user)
        count = 4
        until count == 0 
            puts "incorrect password. You have #{count} more attempts"
            new_password = STDIN.gets.strip
            count -= 1
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
        # elsif input == 3
        #     Artist.update_an_event(artist)
        elsif input == 3 
            welcome 
        else 
            "That is not a valid command"
            artist_profile(artist)
        end 
    end 

    def self.search_artist_usernames(username)
        Artist.find_by(username: username)
    end 

    def self.create_new_profile_menu
         system("clear")
         puts "Make a selection"
         puts "-------------------"
         puts ""
         puts "1) Create new artist profile"
         #puts "2) Create new venue profile"
         puts "2) return to main menu"
         input = STDIN.gets.strip.to_i 
         if input == 1
            system("clear")
            create_new_artist
         #elsif input == 2
         #   create_new_venue
         elsif input == 2
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

# def self.create_new_venue

# end 

def self.check_artist_username(username)
    Artist.where(username: username)
end 



# #from welcome -> sends to creates new artist or new venue
# def create_new_profile
#     puts "1) create new venue"
#     puts "2) create new artist" 
#     input = gets.strip.to_i 
#     if input == 1 
#         Venue.create_new_profile
#     elsif input == 2 
#         Artist.create_new_profile 
#     else 
#         puts "I do not understand that command"
        
#     end 
# end 

# def self.artist_welcome(artist_id)


# end 

# def fan_search_for_artist
#     puts "enter the artist name" 
#     artist_name = gets.strip
#     my_artist = Artist.find_an_artist(artist_name)
# end 


# def use_existing_venue
#     Venue.find_a_venue
# end 

# def create_new_venue
# end 

# def fan_of_music
#     puts "Would you like to:"
#     puts "1) View all events"
#     puts "2) View all upcoming events"
#     puts "3) View all past events"
#     puts "4) view events by venue"
#     puts "5) view events by artist"
#     puts "5) view events by zip code" 
#     puts " Go back to the start"
# end 

# def day_of_event
#     puts "enter the year of the event: format as 'yyyy'"
#     year = STDIN.gets.strip
#     if (year.to_i.is_a? Integer) == false || year.size != 4
#         puts "please enter a valid year:"
#         puts "example: 2019"
#         day_of_event
#     else 
#         month = self.find_month
#         day = self.find_day
#     end  
#     date = "#{year.to_i}-#{month.to_i}-#{day.to_i}" 
#     date 
# end 

# def find_month
#     puts "enter month of the event: format as 'mm'"
#     month = STDIN.gets.strip
#     if (month.to_i.is_a? Integer) == false || month.to_i > 12 || month.to_i < 1
#         puts "please enter a valid month:"
#         puts "example: 01"
#         find_month
#     else 
#         month
#     end 
# end 

# def find_day 
#     puts "enter day of the event: format as 'dd'"
#         day = STDIN.gets.strip
#     if (day.to_i.is_a? Integer) == false || day.to_i > 31 || day.to_i < 1
#         puts "please enter a valid day:"
#         puts "example: 01"
#         find_day
#     else 
#         day 
#     end 
# end 

 end 



