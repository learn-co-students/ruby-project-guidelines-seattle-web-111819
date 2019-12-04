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
# request.body = 'fields name; sort id; limit 500;'
# games = JSON.parse(http.request(request).body)


games = [{"id"=>1, "name"=>"Thief II: The Metal Age"},
{"id"=>2, "name"=>"Thief: The Dark Project"},
{"id"=>3, "name"=>"Thief: Deadly Shadows"},
{"id"=>4, "name"=>"Thief"},
{"id"=>5, "name"=>"Baldur's Gate"},
{"id"=>6, "name"=>"Baldur's Gate II: Shadows Of Amn"},
{"id"=>7, "name"=>"Jagged Alliance"},
{"id"=>8, "name"=>"Jagged Alliance: Deadly Games"},
{"id"=>9, "name"=>"Jagged Alliance 2"},
{"id"=>10, "name"=>"Jade Empire: Special Edition"},
{"id"=>11, "name"=>"Vampire: The Masquerade - Bloodlines"},
{"id"=>12, "name"=>"Vampire: The Masquerade - Redemption"},
{"id"=>13, "name"=>"Fallout"},
{"id"=>14, "name"=>"Fallout 2"},
{"id"=>15, "name"=>"Fallout 3"}]

User.find_or_create_by(name: "Adam")
User.find_or_create_by(name: "Bob")
User.find_or_create_by(name: "Carla")
User.find_or_create_by(name: "Delila")
User.find_or_create_by(name: "Ed")
User.find_or_create_by(name: "Frank")
User.find_or_create_by(name: "Grace")
User.find_or_create_by(name: "Hanna")

Review.find_or_create_by(review_text: "Good!", rating: 10, user_id: 2, game_id: 4)



games.each do |game|
    Game.find_or_create_by(name: game["name"])
end

