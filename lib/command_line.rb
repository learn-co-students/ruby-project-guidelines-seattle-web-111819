
def run
    main_menu
end


# The Main Menu
def main_menu(user="guest")
    router = nil
    message = []
    # base options
    options = [
        ["Log In", 3],
        ["Create Account", 5],
        ["Continue as a Guest", 8],
        ["Select a Game", 8],
        ["My Account", 6],
        ["Log Out", 4],
        ["Exit", 1]
    ]
    # removing options based on status
    if user == "guest"
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
    menu_routing(user, "", router)
end

# The Login Menu
def login
    entry = nil
    message = []
    until entry
        display_menu_header(["Log In:"])
        entry = display_string_menu(["Please type your name:  "], message)
        message = ["Sorry, invalid account name. Please try again...", "You can also type 'exit' to exit or 'main' to go back."]
        exit_game_reviews if entry.downcase == "exit"
        main_menu if entry.downcase == "main"
        new_name = entry.split(' ')[0].gsub(/[^a-z]/i, '').downcase.capitalize
        user = User.find_by(name: new_name)
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
    entry = nil
    message = []
    until entry
        display_menu_header(["Create an Account:"])
        entry = display_string_menu(["Please type your name:  ",], message)
        exit_game_reviews if entry == "exit"
        main_menu if entry == "main"
        new_name = entry.split(' ')[0].gsub(/[^a-z]/i, '').downcase.capitalize
        if new_name == "Guest"
            message = ["Sorry, 'guest' is not an acceptable name. Please try again..."]
            entry = nil
        elsif User.find_by(name: new_name)
            message = ["Sorry, '#{new_name}' is already taken. Please try again..."]
            entry = nil
        end
    end
    user = User.create(name: new_name)
    display_footer(["Account successfully created, #{user.name}!"])
    main_menu(user)
end

# Update the User account
def my_account(user)
    router = nil
    message = []
    # base options
    options = [
        ["Change Name", 12],
        ["My Reviews", 13],
        ["Delete Account", 7],
        ["Log Out", 4],
        ["Main Menu", 2],
        ["Exit", 1]
    ]
    # removing options based on status
    if Review.where(user_id: user.id).count == 0
        options.delete_at(1)
    end
    # display loop until validated choice
    until router
        display_menu_header(["My Account:"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    menu_routing(user, "", router)
end

# Change the User name
def change_name(user)

end

# List User's reviews
def my_reviews(user)

end

# Delete the User account
def delete_account(user)
    display_menu_header(["Delete your Account:"], user)
    entry = display_string_menu(["Are you sure you want to delete your account?", "This will delete all your reviews as well!", "Please confirm by typing in your account name:  "], [""])
    new_name = entry.downcase.capitalize
    if User.find_by(name: new_name) == user
        Review.where(user_id: user.id).destroy_all
        user.destroy
        display_footer(["All data associated with '#{new_name}' successfully deleted..."])
        user = "guest"
    else
        display_footer(["Account NOT deleted.", "Returning to the Main Menu."])
    end
    main_menu(user)
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
        exit_game_reviews if entry.downcase == "exit"
        main_menu if entry.downcase == "main"
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
        ["Log In", 3],
        ["Write a Review", 10],
        ["Update Your Review", 11],
        ["Read Reviews", 9],
        ["Choose Another Game", 8],
        ["Main Menu", 2],
        ["Exit", 1]
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
    menu_routing(user, game, router)
end

# Read some Reviews
def read_reviews(user, game)

end

# Write a Review
def write_review(user, game)
    
end

# Delete the User's Review
def delete_review

end

# Routing between menus
def menu_routing(user, game, router)
    exit_game_reviews if router == 1
    main_menu(user) if router == 2
    login if router == 3
    logout(user) if router == 4
    create_account if router == 5
    my_account(user) if router == 6
    delete_account(user) if router == 7
    choose_game(user) if router == 8
    read_reviews(user, game) if router == 9
    write_review(user, game) if router == 10
    update_review(user, game) if router == 11
    change_name(user) if router == 12
    my_reviews(user) if router == 13
end

# Get me out of here!
def exit_game_reviews
    display_footer(["Thanks for using Game Reviews!", "Goodbye!", "", ""])
    system('clear')
    exit
end