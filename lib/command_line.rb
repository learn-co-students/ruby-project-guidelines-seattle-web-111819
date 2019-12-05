class CommandLine
def run
    system("clear")
    welcome 
end 

def exit_program
    puts "Thanks for using Easy Music!"
end 

def welcome 
    puts "Welcome to Easy Music"
    puts "Are you using Easy Music as..."
    puts "1) Artist"
    puts "2) Venue"
    puts "To quit Easy Music, enter: 'exit'"
    input = gets.strip
    if input.to_i == 1 || input.downcase == "artist"
        Artist.artist_welcome 
     elsif input.to_i == 2 || input.downcase == "venue"
        Venue.venue_welcome
     elsif input.downcase == "exit" || input.downcase == "exit!"
        exit_program
     else 
        puts "Sorry, I don't understand your selection"
        puts "Please try again"
        welcome 
     end 
end 

def fan_search_for_artist
    puts "enter the artist name" 
    artist_name = gets.strip
    my_artist = Artist.find_an_artist(artist_name)
end 


def use_existing_venue
    Venue.find_a_venue
end 

def create_new_venue
end 

def fan_of_music
    puts "Would you like to:"
    puts "1) View all events"
    puts "2) View all upcoming events"
    puts "3) View all past events"
    puts "4) view events by venue"
    puts "5) view events by artist"
    puts "5) view events by zip code" 
    puts " Go back to the start"
end 

def day_of_event
    puts "enter the year of the event: format as 'yyyy'"
    year = STDIN.gets.strip
    if (year.to_i.is_a? Integer) == false || year.size != 4
        puts "please enter a valid year:"
        puts "example: 2019"
        day_of_event
    else 
        month = self.find_month
        day = self.find_day
    end  
    date = "#{year.to_i}-#{month.to_i}-#{day.to_i}" 
    date 
end 

def find_month
    puts "enter month of the event: format as 'mm'"
    month = STDIN.gets.strip
    if (month.to_i.is_a? Integer) == false || month.to_i > 12 || month.to_i < 1
        puts "please enter a valid month:"
        puts "example: 01"
        find_month
    else 
        month
    end 
end 

def find_day 
    puts "enter day of the event: format as 'dd'"
        day = STDIN.gets.strip
    if (day.to_i.is_a? Integer) == false || day.to_i > 31 || day.to_i < 1
        puts "please enter a valid day:"
        puts "example: 01"
        find_day
    else 
        day 
    end 
end 

end 



