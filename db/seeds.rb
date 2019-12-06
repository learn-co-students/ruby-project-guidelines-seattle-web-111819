require 'net/http'
require 'open-uri'
require 'json'
require 'pry'
 
url = "https://www.googleapis.com/books/v1/volumes?q=Harry+Potter"

response = RestClient.get(url)

json_data = JSON.parse(response)
books = json_data["items"]

books.each do |book|
    p "*********************"
    p "Title: " + book["volumeInfo"]["title"]
    p "Author " + book["volumeInfo"]["authors"][0].to_s
    
    Book.find_or_create_by(title: book["volumeInfo"]["title"], 
                author: book["volumeInfo"]["authors"][0].to_s)
    # binding.pry
end

u1 = User.create(name: "Nicole")
u2 = User.create(name: "Alice")
u3 = User.create(name: "Cole")
u4 = User.create(name: "Sean")
u5 = User.create(name: "Jacob")
u6 = User.create(name: "Josh")
u7 = User.create(name: "Sergio")

r1 = Review.find_or_create_by(user_id: 1, book_id: 1, rating: 3, message: "The book was okay." )
r2 = Review.find_or_create_by(user_id: 2, book_id: 2, rating: 5, message: "The series was phenomenal!" )
r3 = Review.find_or_create_by(user_id: 3, book_id: 3, rating: 5, message: "Wow!" )
r4 = Review.find_or_create_by(user_id: 4, book_id: 4, rating: 4, message: "A great book." )
r5 = Review.find_or_create_by(user_id: 5, book_id: 5, rating: 4, message: "High enjoyable!" )
r6 = Review.find_or_create_by(user_id: 6, book_id: 6, rating: 1, message: "Not good at all." )
r7 = Review.find_or_create_by(user_id: 7, book_id: 7, rating: 2, message: "Meh." )
r8 = Review.find_or_create_by(user_id: 1, book_id: 8, rating: 3, message: "It was okay." )
r9 = Review.find_or_create_by(user_id: 2, book_id: 9, rating: 4, message: "Amazing!" )
r10 = Review.find_or_create_by(user_id: 3, book_id: 10, rating: 4, message: "Incredible!" )
r11 = Review.find_or_create_by(user_id: 4, book_id: 3, rating: 5, message: "Wow! I loved this series!" )
r12 = Review.find_or_create_by(user_id: 5, book_id: 3, rating: 5, message: "Amazing world building and characters!" )


# binding.pry
   
puts "done seeding"