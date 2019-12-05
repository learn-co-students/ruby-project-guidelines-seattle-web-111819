require 'pry'
# https://api-v3.igdb.com/games
# user_key: "bea99e40326fc66d0145d65bff646876"

###### Sample API request from source page: ######
# require 'net/https'
# http = Net::HTTP.new('api-v3.igdb.com',443)
# http.use_ssl = true
# request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/games'), {'user-key' => YOUR_KEY})
# request.body = 'fields age_ratings,aggregated_rating,aggregated_rating_count,alternative_names,artworks,bundles,category,collection,cover,created_at,dlcs,expansions,external_games,first_release_date,follows,franchise,franchises,game_engines,game_modes,genres,hypes,involved_companies,keywords,multiplayer_modes,name,parent_game,platforms,player_perspectives,popularity,pulse_count,rating,rating_count,release_dates,screenshots,similar_games,slug,standalone_expansions,status,storyline,summary,tags,themes,time_to_beat,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos,websites;'
# puts http.request(request).body
##################################################


###### My API request ############################
# require 'net/https'
# http = Net::HTTP.new('api-v3.igdb.com',443)
# http.use_ssl = true
# request = Net::HTTP::Post.new(URI('https://api-v3.igdb.com/games'), {'user-key' => "bea99e40326fc66d0145d65bff646876"})
# request.body = 'fields name, rating, rating_count, first_release_date; where rating_count > 200 & rating > 70; sort id; limit 500;'
# games = JSON.parse(http.request(request).body)
# games.each {|game| Game.find_or_create_by(name: game["name"], lowercase_name: game["name"].downcase, igdb_rating: game["rating"], release_date: game["first_release_date"], igdb_rating_count: game["rating_count"])}


User.find_or_create_by(name: "Antidisestablishmentarianism")
User.find_or_create_by(name: "Bob")
User.find_or_create_by(name: "Carla")
User.find_or_create_by(name: "Delila")
User.find_or_create_by(name: "Ed")
User.find_or_create_by(name: "Frank")
User.find_or_create_by(name: "Grace")
User.find_or_create_by(name: "Hanna")
User.find_or_create_by(name: "Ivan")
User.find_or_create_by(name: "Jana")
User.find_or_create_by(name: "Klaus")
User.find_or_create_by(name: "Lena")
User.find_or_create_by(name: "Marv")
User.find_or_create_by(name: "Nan")
User.find_or_create_by(name: "Olaf")
User.find_or_create_by(name: "Paul")



Review.find_or_create_by(user_id: 1, game_id: 3, rating: 100, review_text: "This game is the absolute best! I've spent about 200 hours playing this game so far and I haven't even taken a bathroom break! Which is weird, because I've had an awful lot of coffee... But whatever, it's amazing! That thing you do in the second level? EPIC! EPIC I TELL YOU!!! That other user, you know the one, he says this game sucks, but he has no idea what he's talking about! This game will be the game of the year! No, no, the game of the CENTURY!! Did I mention it was amazing? Clearly not enough, because it's SUPER DUPER AMAZE-BALLS! I think I may need to eat though. All I've had are cheese balls and Dew. LOTS of Dew. Like EPIC amounts of Dew. Enough to drown a horde of Nifleheim giants! Perhaps I should go befoior eiwaaaaaaaaaaa")
Review.find_or_create_by(user_id: 2, game_id: 3, rating: 94, review_text: "I'm a long long long long long long long long long long long long long review. Don't delete me! I'm a long long long long long long long long long long long long long review. Don't delete me! I'm a long long long long long long long long long long long long long review.")
Review.find_or_create_by(user_id: 3, game_id: 3, rating: 80, review_text: "Good!")
Review.find_or_create_by(user_id: 4, game_id: 3, rating: 90, review_text: "Yeet!")
Review.find_or_create_by(user_id: 5, game_id: 3, rating: 50, review_text: "Don't delete me!!")
Review.find_or_create_by(user_id: 6, game_id: 3, rating: 50, review_text: "What?")
Review.find_or_create_by(user_id: 7, game_id: 3, rating: 50, review_text: "Cool")
Review.find_or_create_by(user_id: 9, game_id: 3, rating: 50, review_text: "Waste of time, in a good way")
Review.find_or_create_by(user_id: 10, game_id: 3, rating: 50, review_text: "Yeet again!")
Review.find_or_create_by(user_id: 11, game_id: 3, rating: 50, review_text: "Aw, CRUD")
Review.find_or_create_by(user_id: 12, game_id: 3, rating: 50, review_text: "Nonsense")
Review.find_or_create_by(user_id: 13, game_id: 3, rating: 50, review_text: "Simple")
Review.find_or_create_by(user_id: 14, game_id: 3, rating: 50, review_text: "Yet another review")
Review.find_or_create_by(user_id: 15, game_id: 3, rating: 50, review_text: " ")
Review.find_or_create_by(user_id: 16, game_id: 3, rating: 10, review_text: " ")
Review.find_or_create_by(user_id: 2, game_id: 14, rating: 100, review_text: "This game is the absolute best! I've spent about 200 hours playing this game so far and I haven't even taken a bathroom break! Which is weird, because I've had an awful lot of coffee... But whatever, it's amazing! That thing you do in the second level? EPIC! EPIC I TELL YOU!!! That other user, you know the one, he says this game sucks, but he has no idea what he's talking about! This game will be the game of the year! No, no, the game of the CENTURY!! Did I mention it was amazing? Clearly not enough, because it's SUPER DUPER AMAZE-BALLS! I think I may need to eat though. All I've had are cheese balls and Dew. LOTS of Dew. Like EPIC amounts of Dew. Enough to drown a horde of Nifleheim giants! Perhaps I should go befoior eiwaaaaaaaaaaa")
Review.find_or_create_by(user_id: 2, game_id: 1, rating: 94, review_text: "I'm a long long long long long long long long long long long long long review. Don't delete me! I'm a long long long long long long long long long long long long long review. Don't delete me! I'm a long long long long long long long long long long long long long review.")
Review.find_or_create_by(user_id: 2, game_id: 2, rating: 80, review_text: "Good!")
Review.find_or_create_by(user_id: 2, game_id: 4, rating: 90, review_text: "Yeet!")
Review.find_or_create_by(user_id: 2, game_id: 5, rating: 50, review_text: "Don't delete me!!")
Review.find_or_create_by(user_id: 2, game_id: 6, rating: 50, review_text: "What?")
Review.find_or_create_by(user_id: 2, game_id: 7, rating: 50, review_text: "Cool")
Review.find_or_create_by(user_id: 2, game_id: 8, rating: 50, review_text: "Waste of time, in a good way")
Review.find_or_create_by(user_id: 2, game_id: 9, rating: 50, review_text: "Yeet again!")
Review.find_or_create_by(user_id: 2, game_id: 10, rating: 50, review_text: "Aw, CRUD")
Review.find_or_create_by(user_id: 2, game_id: 11, rating: 50, review_text: "Nonsense")
Review.find_or_create_by(user_id: 2, game_id: 12, rating: 50, review_text: "Simple")
Review.find_or_create_by(user_id: 2, game_id: 13, rating: 50, review_text: "Yet another review")
    


