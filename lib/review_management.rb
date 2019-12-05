# (ROUTER 19): Read a Review
def read_review(user, game, review, tracer=2)
    chopped = review.review_text.split(" ")
    first = chopped.shift
    formatted = chopped.reduce([first]) do |memo, word|
        memo[-1].length + word.length < $sp[:w] - 6 ? memo[-1] = memo[-1] + " " + word : memo << word
        memo
    end
    display_menu_header(["A Review of", "'#{game.name}'", "by #{User.find(review.user_id).name}"], user)
    buffer = ($sp[:w] - 14)/2
    puts " " * $sp[:l] + "|" + " " * buffer + "#{review.rating < 10 ? " " : ""}#{review.rating} out of 10" + " " * buffer + "|"
    puts " " * $sp[:l] + "|" + " " * ($sp[:w] - 2) + "|"
    formatted.each {|line| puts " " * $sp[:l] + "|  " + line + " " * ($sp[:w] - 4 - line.length) + "|"}
    puts " " * $sp[:l] + "-" * $sp[:w]
    display_footer([])
    menu_routing(user, game, tracer)
end

# (ROUTER 10): Write a Review
def write_review(user, game, tracer=2)
    display_menu_header(["Your Review of", "'#{game.name}'."], user)
    rating = 0
    message = []
    until rating > 0 && rating < 11
        entry = display_string_menu(["Please give this game a rating from 1-10:  "], message)
        message = ["Sorry, invalid entry."]
        rating = entry.to_i
    end
    review_text = display_string_menu(["Please write a short review of", "'#{game.name}' below:", "", "-" * $sp[:w], ""], [])
    Review.create(rating: rating, review_text: review_text, user_id: user.id, game_id: game.id)
    display_footer(["Review successfully saved for", "'#{game.name}'."])
    menu_routing(user, game, tracer)
end

# (ROUTER 13): List the User's Reviews
def my_reviews(user)

end

# (ROUTER 16): Update the User's Review rating
def update_review_rating(user, game, tracer)
    display_menu_header(["Your Review of", "'#{game.name}'."], user)
    rating = 0
    message = []
    until rating > 0 && rating < 11
        entry = display_string_menu(["Please give this game a rating from 1-10:  "], message)
        message = ["Sorry, invalid entry."]
        rating = entry.to_i
    end
    Review.find_by(user_id: user.id, game_id: game.id).update(rating: rating)
    display_footer(["Review rating successfully updated for", "'#{game.name}'"])
    menu_routing(user, game, tracer)
end

# (ROUTER 17): Update the User's Review text
def update_review_text(user, game, tracer)
    display_menu_header(["Update your Review of", "'#{game.name}'."], user)
    entry = display_string_menu(["Please update your review of", "'#{game.name}' below:", "", "-" * $sp[:w], ""], [""])
    Review.find_by(user_id: user.id, game_id: game.id).update(review_text: entry)
    display_footer(["Review text successfully updated for", "'#{game.name}'."])
    menu_routing(user, game, tracer)
end

# (ROUTER 18): Delete the User's Review
def delete_review(user, game, tracer)
    display_menu_header(["Delete your Review for", "'#{game.name}'"], user)
    entry = display_string_menu(["Are you sure you want to delete your review for", "'#{game.name}'?", "Please confirm by typing in 'yes' or 'delete':  "], [""])
    if ["yes", "delete"].include?(entry.downcase)
        Review.find_by(user_id: user.id, game_id: game.id).destroy
        display_footer(["Your review has been successfully deleted..."])
    else
        display_footer(["Review NOT deleted."])
    end
    menu_routing(user, game, tracer)
end