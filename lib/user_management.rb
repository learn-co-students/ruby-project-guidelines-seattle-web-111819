# (ROUTER 3): The Login Menu
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

# (ROUTER 4): Logs the user out
def logout(user)
    display_footer(["You have successfully logged out, #{user.name}."])
    main_menu
end

# (ROUTER 5): Creates a User and logs in
def create_account
    entry = nil
    message = []
    until entry
        display_menu_header(["Create an Account:"])
        entry = display_string_menu(["You can type 'exit' to exit and 'main' to go back.", "Please type your name:  ",], message)
        exit_game_reviews if entry == "exit"
        main_menu(user) if entry == "main"
        new_name = entry.split(' ')[0].gsub(/[^a-z]/i, '').downcase.capitalize
        if new_name == "Guest"
            message = ["Sorry, 'guest' is not an acceptable name. Please try again..."]
            entry = nil
        elsif User.find_by(name: new_name)
            message = ["Sorry, '#{new_name}' is already taken. Please try again..."]
            entry = nil
        end
    end
    user.name = new_name
    display_footer(["Account successfully created, #{user.name}!"])
    main_menu(user)
end

# (ROUTER 12): Change the User name
def change_name(user)
    entry = nil
    message = []
    until entry
        display_menu_header(["Change Your Account Name:"], user)
        entry = display_string_menu(["You can type 'exit' to exit and 'main' to go back.", "Please type your new name:  ",], message)
        exit_game_reviews if entry == "exit"
        main_menu(user) if entry == "main"
        new_name = ""
        new_name = entry.split(' ')[0].gsub(/[^a-z]/i, '').downcase.capitalize if entry
        if new_name == "Guest"
            message = ["Sorry, 'guest' is not an acceptable name. Please try again..."]
            entry = nil
        elsif new_name.size < 2
            message = ["Sorry, your name is too short. Please try again..."]
            entry = nil
        elsif User.find_by(name: new_name) && new_name != user.name
            message = ["Sorry, '#{new_name}' is already taken. Please try again..."]
            entry = nil
        end
    end
    user.update(name: new_name)
    display_footer(["Account successfully updated, #{user.name}!"])
    main_menu(user)
end

# (ROUTER 7): Delete the User account
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