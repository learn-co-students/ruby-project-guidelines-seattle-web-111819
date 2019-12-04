
def run
    main_menu
end



# The Main Menu
def main_menu(user="guest")
    router = nil
    message = []
    # base options
    options = [
        ["Log In", 1],
        ["Create Account", 2],
        ["Continue as a Guest", 3],
        ["Select a Game", 3],
        ["Log Out", 7],
        ["Update Account", 5],
        ["Delete Account", 6],
        ["Exit", 4]
    ]
    # removing options based on status
    if user == "guest"
        options.delete_at(6)
        options.delete_at(5)
        options.delete_at(4)
        options.delete_at(3)
    else
        options.delete_at(2)
        options.delete_at(1)
        options.delete_at(0)
    end
    # display loop until validated choice
    until router
        display_menu_header(["Main Menu:"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    # routing based on selection
    login if router == 1
    create_account if router == 2
    choose_game(user) if router == 3
    exit_game_reviews if router == 4
    update_account(user) if router == 5
    delete_account(user) if router == 6
    logout(user) if router == 7
end

# The Login Menu
def login
    entry = nil
    message = []
    until entry
        display_menu_header(["Log In:"])
        entry = display_string_menu(["Please type your name:  "], message)
        message = ["Sorry, invalid account name. Please try again...", "You can also type 'exit' to exit or 'main' to go back."]
        exit_game_reviews if entry == "exit"
        main_menu if entry == "main"
        user = User.find_by(name: entry)
        entry = nil if !user || user == "guest"
    end
    display_footer(["You've been logged in, #{user.name}!"])
    main_menu(user)
end

# Logs the user out
def logout(user)
    display_footer(["You have successfully logged out, #{user.name}."])
    main_menu
end

# Creates a User and logs in
def create_account

end

# Update the User account
def update_account(user)

end

# Delete the User account
def delete_account(user)

end

# User finds a game by the title
def choose_game(user)
    user == "guest" ? username = "guest" : username = user.name
    entry = nil
    message = []
    until entry
        display_menu_header(["Game Search:"], user)
        entry = display_string_menu(["Please type a game title (or 'exit'/'main'):  "], message)
        message = ["Sorry, invalid game title. Please try again...", "You can also type 'exit' to exit or 'main' to go back."]
        exit_game_reviews if entry == "exit"
        main_menu if entry == "main"
        game = Game.find_by(name: entry)
        entry = nil if !game
    end
    display_footer(["Found an entry for #{game.name}!"])
    game_menu(user, game)
end

# Options menu for the chosen game
def game_menu(user, game)
    router = nil
    message = []
    # base options
    options = [
        ["Log In", 6],
        ["Write a Review", 5],
        ["Update Your Review", 7],
        ["Read Reviews", 1],
        ["Choose Another Game", 2],
        ["Main Menu", 3],
        ["Exit", 4]
    ]
    # removing options based on status
    if user == "guest"
        options.delete_at(2)
        options.delete_at(1)
    elsif Review.find_by(user_id: user.id)
        options.delete_at(1)
        options.delete_at(0)
    else
        options.delete_at(2)
        options.delete_at(0)
    end
    # display loop until validated choice
    until router
        display_menu_header(["#{game.name}:"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    # routing based on selection
    read_reviews(user, game) if router == 1
    write_review(user, game) if router == 5
    choose_game(user) if router == 2
    main_menu(user) if router == 3
    exit_game_reviews if router == 4
    login if router == 6
    update_review(user, game) if router
end

def read_reviews(user, game)

end

def write_review(user, game)
    
end

def exit_game_reviews
    display_footer(["Thanks for using Game Reviews!", "Goodbye!", "", ""])
    system('clear')
    exit
end