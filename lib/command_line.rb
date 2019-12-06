# Program start
def run
    system('clear')
    graphic_welcome
    graphic_bottom
    print "\n" + " " * 40 + "Press any key to continue... "
    STDIN.getch
    puts ""
    main_menu
end



# (ROUTER 2):
# The Main Menu
def main_menu(user="guest")
    game = nil
    router = nil
    message = []
    # base options
    options = [
        ["Continue as a Guest", 8],
        ["Log In", 3],
        ["Create Account", 5],
        ["Select a Game", 8],
        ["My Reviewed Games", 13],
        ["Log Out", 4],
        ["My Account", 6],
        ["Exit", 1]
    ]
    # removing options based on status
    if user == "guest"
        options.delete_at(6)
        options.delete_at(5)
        options.delete_at(4)
        options.delete_at(3)
    elsif Review.where(user_id: user.id).count == 0
        options.delete_at(4)
        options.delete_at(2)
        options.delete_at(1)
        options.delete_at(0)
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



# (ROUTER 6):
# My Account Menu
def my_account(user)
    router = nil
    message = []
    # base options
    options = [
        ["Change Name", 12],
        ["Delete Account", 7],
        ["Log Out", 4],
        ["Main Menu", 2],
        ["Exit", 1]
    ]
    # display loop until validated choice
    until router
        display_menu_header(["My Account:"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    menu_routing(user, "", router)
end



# (ROUTER 14):
# User finds a game by the title
def choose_game(user)
    user == "guest" ? username = "guest" : username = user.name
    entry = nil
    message = []
    until entry
        display_menu_header(["Game Search:"], user)
        entry = display_string_menu(["Please type a game title:  "], message)
        message = ["Sorry, invalid game title. Please try again...", "You can also type 'exit' to exit or 'main' to go back."]
        exit_game_reviews if entry.downcase == "exit"
        main_menu(user) if entry.downcase == "main"
        game = Game.find_by(lowercase_name: entry.downcase)
        game = Game.where(["name like ?", "%#{entry.downcase}%"]).limit(1)[0] if !game
        entry = nil if !game || entry.size < 3
    end
    display_footer(["Found an entry for #{game.name}!"])
    game_menu(user, game)
end



# (ROUTER 15):
# Options menu for the chosen game
def game_menu(user, game, tracer=2)
    choose_game(user) if !game
    reviews = Review.where(game_id: game.id)
    avg_rating = reviews.count == 0 ? " --- " : (reviews.sum(:rating).to_f / reviews.count).round(2)
    myrev = nil
    myrev = reviews.find_by(user_id: user.id) if user != "guest"
    myrev ? myrev = myrev.id * 100 : myrev = 2
    router = nil
    message = []
    # base options
    options = [
        ["Read Reviews", 9],
        ["Write a Review", 10],
        ["Read My Review", myrev],
        ["Update My Review", 11],
        ["My Reviewed Games", 13],
        ["Choose Another Game", 8],
        ["Log In", 3],
        ["Previous Menu", tracer],
        ["Main Menu", 2],
        ["Exit", 1]
    ]
    # removing options based on status
    if user == "guest"
        options.delete_at(4)
        options.delete_at(3)
        options.delete_at(2)
        options.delete_at(1)
    elsif myrev > 99
        options.delete_at(6)
        options.delete_at(1)
    elsif !Review.find_by(user_id: user.id)
        options.delete_at(6)
        options.delete_at(4)
        options.delete_at(3)
        options.delete_at(2)
    else
        options.delete_at(6)
        options.delete_at(3)
        options.delete_at(2)
    end
    options.delete_at(0) if reviews.count == 0
    # display loop until validated choice
    until router
        display_menu_header(["#{game.name}:", "Release Date: #{Time.at(game.release_date.to_i).strftime('%m/%d/%Y')}", "Average GR Rating:   #{avg_rating} (based on #{reviews.count} ratings)", "Average IGDB Rating: #{game.igdb_rating.round(2)} (based on #{game.igdb_rating_count} ratings)"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    menu_routing(user, game, router, 15)
end



# (ROUTER 9):
# List the Reviews for a Game
def game_reviews(user, game, tracer=2)
    router = nil
    message = []
    # base options
    user == "guest" ? user_num = 0 : user_num = user.id
    reviews = Review.where(game_id: game.id).limit(32).order(:id)
    options = reviews.map do |review|
        name = User.find(review.user_id).name
        name.length < 15 ? name = name + " " * (14 - name.length) : name = name[0,11] + "..."
        rat = review.rating.to_s
        until rat.length == 3
            rat = " " + rat
        end
        rev = review.review_text
        rev = rev[0,$sp[:w] - 34] + "..." if rev.length > $sp[:w] - 31
        line = [name + " | " + rat + " | " + rev, review.id * 100]
        line[0] = line[0] + " " * ($sp[:w] - line[0].length - 7) + "|\n" + " " * $sp[:l] + "|" + "-" * ($sp[:w] - 2) if reviews[-1] == review
        line
    end
    options += [
        ["Previous Menu", tracer],
        ["Main Menu", 2],
        ["Exit", 1]
    ]
    until router
        display_menu_header(["'#{game.name}' reviews:", "", "      User:           1-100: Review:"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    menu_routing(user, game, router, 9)
end



# (ROUTER 13):
# List the User's Reviewed Games
def my_reviews(user, game, tracer=2)
    router = nil
    message = []
    # base options
    reviews = Review.where(user_id: user.id).limit(32).order(:id)
    options = reviews.map do |review|
        game_name = Game.find(review.game_id).name
        game_name.length < 35 ? game_name = game_name + " " * (34 - game_name.length) : game_name = game_name[0,31] + "..."
        rat = review.rating.to_s
        until rat.length == 3
            rat = " " + rat
        end
        rev = review.review_text
        rev = rev[0,$sp[:w] - 54] + "..." if rev.length > $sp[:w] - 51
        line = [game_name + " | " + rat + " | " + rev, review.id * 100]
        line[0] = line[0] + " " * ($sp[:w] - line[0].length - 7) + "|\n" + " " * $sp[:l] + "|" + "-" * ($sp[:w] - 2) if reviews[-1] == review
        line
    end
    options += [
        ["Previous Menu", tracer],
        ["Main Menu", 2],
        ["Exit", 1]
    ]
    until router
        display_menu_header(["Your reviewed games:", "", "      Game:                               1-100: Review:"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    menu_routing(user, Game.find(Review.find(router / 100).game_id), 15, 13) if router > 99
    menu_routing(user, game, router, 13)
end



# (ROUTER 11):
# Update Review Menu
def update_review(user, game, tracer=2)
    router = nil
    message = []
    # base options
    options = [
        ["Update My Review Rating", 16],
        ["Update My Review Text", 17],
        ["Delete My Review", 18],
        ["Previous Menu", tracer],
        ["Main Menu", 2],
        ["Exit", 1]
    ]
    # display loop until validated choice
    until router
        display_menu_header(["#{game.name}:"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    menu_routing(user, game, router, tracer)
end



# (ROUTER 1):
# Get me out of here!
def exit_game_reviews
    system('clear')
    graphic_thanks
    graphic_bottom
    print "\n" + " " * 40 + "Press any key to continue... "
    STDIN.getch
    puts ""
    system('clear')
    exit
end