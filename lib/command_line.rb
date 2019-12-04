def run
    # menu spacing values
    sp = {t: 10, l: 20, w: 80}
    main_menu(sp)
end



# Displays the menu header and sends the remainder to the proper method
# Returns the validated input
def display_menu(header, choices, message, sp)
    system('clear')
    puts "\n" * sp[:t]
    puts " " * sp[:l] + header[0]
    puts " " * sp[:l] + header[1]
    puts " " * sp[:l] + "-" * sp[:w]
    input = option_menu(choices, message, sp) if choices.count > 1
    input = string_menu(choices, message, sp) if choices.count < 2
    input
end

# Menu body for multi-option menus
# Validates and returns the input
def option_menu(choices, message, sp)
    i = 0
    while i < choices.count
        puts " " * sp[:l] + "|  #{i + 1}) #{choices[i]}" + " " * (sp[:w] - 7 - choices[i].size) + "|"
        i += 1
    end
    puts " " * sp[:l] + "-" * sp[:w]
    puts "\n\n" + " " * sp[:l] + message + "\n"
    print " " * sp[:l] + "Your selection (1-#{choices.count})?  "
    input = STDIN.getch.to_i
    input > 0 && input <= choices.count ? input : nil
end

# Menu body for string requests
# Returns the input
def string_menu(choices, message, sp)
    puts "\n\n" + " " * sp[:l] + message + "\n"
    print " " * sp[:l] + choices[0]
    input = gets.strip
end




# The Main Menu
def main_menu(sp)
    input = nil
    message = ""
    until input
        input = display_menu(["Main Menu:", ""], ["Login", "Create Account", "Continue as a Guest", "Exit"], message, sp)
        message = "Sorry, invalid selection. Please choose again..."
    end
    login(sp) if input == 1
    create_account(sp) if input == 2
    choose_game("guest", sp) if input == 3
    exit_game_reviews(sp) if input == 4
end

# The Login Menu
def login(sp)
    input = nil
    message = ""
    until input
        input = display_menu(["Login:", ""], ["Please type your name (or 'exit'/'main'):  "], message, sp)
        message = "Sorry, invalid account name. Please try again..."
        exit_game_reviews(sp) if input == "exit"
        main_menu(sp) if input == "main"
        input = nil if input == "guest"
        user = User.find_by(name: input)
        input = nil if !user
    end
    puts "\n\n" + " " * sp[:l] + "You've been logged in, #{user.name}!"
    print " " * sp[:l] + "Press any key to continue...  "
    STDIN.getch
    choose_game(user, sp)
end

# Creates a User and logs in
def create_account(sp)

end

# User finds a game by the title
def choose_game(user, sp)
    user == "guest" ? username = "guest" : username = user.name
    input = nil
    message = ""
    until input
        input = display_menu(["Game Search:", "(User: #{username})"], ["Please type a game title (or 'exit'/'main'):  "], message, sp)
        message = "Sorry, invalid game title. Please try again..."
        exit_game_reviews(sp) if input == "exit"
        main_menu(sp) if input == "main"
        game = Game.find_by(name: input)
        input = nil if !game
    end
    puts "\n\n" + " " * sp[:l] + "Found an entry for #{game.name}!"
    print " " * sp[:l] + "Press any key to continue...  "
    STDIN.getch
    game_menu(user, game, sp)
end

# Options menu for the chosen game
def game_menu(user, game, sp)
    user == "guest" ? username = "guest" : username = user.name
    input = nil
    message = ""
    until input
        if user = "guest"
            input = display_menu(["#{game.name}:", "(User: #{username})"], ["Read Reviews", "(Write a Review) Must be logged in to write a review!", "Choose Another Game", "Main Menu", "Exit"], message, sp)
            input = nil if input == 2
        else
            input = display_menu(["#{game.name}:", "(User: #{username})"], ["Read Reviews", "Write a Review", "Choose Another Game", "Main Menu", "Exit"], message, sp)
        end
            message = "Sorry, invalid selection. Please choose again..."
    end
    read_reviews(user, game, sp) if input == 1
    write_review(user, game, sp) if input == 2
    choose_game(user, sp) if input == 3
    main_menu(sp) if input == 4
    exit_game_reviews(sp) if input == 5
end

def read_reviews(user, game, sp)

end

def write_review(user, game, sp)

end

def exit_game_reviews(sp)
    puts "\n\n" + " " * sp[:l] + "Goodbye!"
    exit
end