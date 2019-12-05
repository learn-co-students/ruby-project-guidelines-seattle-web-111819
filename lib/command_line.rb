# Program start
def run
    main_menu
end

# (ROUTER 2): The Main Menu
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

# (ROUTER 6): My Account Menu
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

# (ROUTER 14): User finds a game by the title
def choose_game(user)
    user == "guest" ? username = "guest" : username = user.name
    entry = nil
    message = []
    until entry
        display_menu_header(["Game Search:"], user)
        entry = display_string_menu(["Please type a game title (or 'exit'/'main'):  "], message)
        message = ["Sorry, invalid game title. Please try again...", "You can also type 'exit' to exit or 'main' to go back."]
        exit_game_reviews if entry.downcase == "exit"
        main_menu(user) if entry.downcase == "main"
        game = Game.find_by(lowercase_name: entry.downcase)
        game = Game.where(["name like ?", "%#{entry.downcase}%"]).limit(1)[0] if !game
        entry = nil if !game
    end
    display_footer(["Found an entry for #{game.name}!"])
    game_menu(user, game)
end

# (ROUTER 15): Options menu for the chosen game
def game_menu(user, game, tracer=2)
    reviews = Review.where(game_id: game.id)
    avg_rating = reviews.count == 0 ? " --- " : (reviews.sum(:rating).to_f / reviews.count).round(2)
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
        display_menu_header(["#{game.name}:", "Release Date: #{Time.at(game.release_date.to_i).strftime('%m/%d/%Y')}", "Average GR Rating:   #{avg_rating} (based on #{reviews.count} ratings)", "Average IGDB Rating: #{game.igdb_rating.round(2)} (based on #{game.igdb_rating_count} ratings)"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    menu_routing(user, game, router, 15)
end

# (ROUTER 9): List the Reviews for a Game
def game_reviews(user, game, tracer=2)
    router = nil
    message = []
    # base options
    user == "guest" ? user_num = 0 : user_num = user.id
    reviews = Review.where(["game_id == ? and user_id != ?", game.id, user_num]).limit(32).order(:id)
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

# (ROUTER 13): List the User's Reviews
def my_reviews(user)
    router = nil
    message = []
    # base options
    reviews = Review.where(user_id: user.id).limit(32).order(:id)
    options = reviews.map do |review|
        game = Game.find(review.game_id).name
        game.length < 25 ? game = game + " " * (24 - game.length) : game = game[0,21] + "..."
        rat = review.rating.to_s
        until rat.length == 3
            rat = " " + rat
        end
        rev = review.review_text
        rev = rev[0,$sp[:w] - 24] + "..." if rev.length > $sp[:w] - 21
        line = [game + " | " + rat + " | " + rev, review.id * 100]
        line[0] = line[0] + " " * ($sp[:w] - line[0].length - 7) + "|\n" + " " * $sp[:l] + "|" + "-" * ($sp[:w] - 2) if reviews[-1] == review
        line
    end
    options += [
        ["Previous Menu", tracer],
        ["Main Menu", 2],
        ["Exit", 1]
    ]
    until router
        display_menu_header(["'#{game.name}' reviews:", "", "      Game:                     1-100: Review:"], user)
        router = display_options_menu(options, message)
        message = ["Sorry, invalid selection. Please choose again..."]
    end
    menu_routing(user, game, router, 13)
end

# (ROUTER 11): Update Review Menu
def update_review(user, game, tracer=2)
    router = nil
    message = []
    # base options
    options = [
        ["Update Your Review Rating", 16],
        ["Update Your Review Text", 17],
        ["Delete Your Review", 18],
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

# (ROUTER 1): Get me out of here!
def exit_game_reviews
    display_footer(["Thanks for using Game Reviews!", "Goodbye!", "", ""])
    system('clear')
    exit
end