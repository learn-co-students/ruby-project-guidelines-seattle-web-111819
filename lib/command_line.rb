# class CommandLine

require 'colorize'
require 'colorized_string'

    def get
    gets.strip
    end
        
    def s_help(num)
        num.times do 
            puts " "
        end
    end

def ascii_art
    s_help(5)
puts     "____________________________________________________".colorize(:cyan)
puts    "|____________________________________________________|".colorize(:cyan)
puts    "| __     __   ____   ___ ||  ____    ____     _  __  |".colorize(:cyan)
puts    "||  |__ |--|_| || |_|   |||_|**|*|__|+|+||___| ||  | |".colorize(:cyan)
puts    "||==|^^||--| |=||=| |=*=||| |~~|~|  |=|=|| | |~||==| |".colorize(:cyan)
puts   " ||  |##||  | | || | |JRO|||-|  | |==|+|+||-|-|~||__| |".colorize(:cyan)
puts    "||__|__||__|_|_||_|_|___|||_|__|_|__|_|_||_|_|_||__|_|".colorize(:cyan)
puts    "||_______________________||__________________________|".colorize(:cyan)
puts    "| _____________________  ||      __   __  _  __    _ |".colorize(:cyan)
puts   " ||=|=|=|=|=|=|=|=|=|=|=| __..\/ |  |_|  ||#||==|  / /|".colorize(:cyan)
puts    "|| | | | | | | | | | | |/\ \  \\|++|=|  || ||==| / / |".colorize(:cyan)
puts    "||_|_|_|_|_|_|_|_|_|_|_/_/\_.___\__|_|__||_||__|/_/__|".colorize(:cyan)
puts   " |____________________ /\~()/()~//\ __________________|".colorize(:cyan)
puts    "| __   __    _  _     \_  (_ .  _/ _    ___     _____|".colorize(:cyan)
puts    "||~~|_|..|__| || |_ _   \ //\\ /  |=|__|~|~|___| | | |".colorize(:cyan)
puts   " ||--|+|^^|==|1||2| | |__/\ __ /\__| |==|x|x|+|+|=|=|=|".colorize(:cyan)
puts   " ||__|_|__|__|_||_|_| /  \ \  / /  \_|__|_|_|_|_|_|_|_|".colorize(:cyan)
puts   " |_________________ _/    \/\/\/    \_ _______________|".colorize(:cyan)
puts   " | _____   _   __  |/      \../      \|  __   __   ___|".colorize(:cyan)
puts   "||_____|_| |_|##|_||   |   \/ __|   ||_|==|_|++|_|-|||".colorize(:cyan)
puts   "||______||=|#|--| |\   \   o    /   /| |  |~|  | | |||".colorize(:cyan)
puts   "||______||_|_|__|_|_\   \  o   /   /_|_|__|_|__|_|_|||".colorize(:cyan)
puts   "|_________ __________\___\____/___/___________ ______|".colorize(:cyan)
puts   " |__    _  /    ________     ______           /| _ _ _|".colorize(:cyan)
puts   " |\ \  |=|/   //    /| //   /  /  / |        / ||%|%|%|".colorize(:cyan)
puts   " | \/\ |*/  .//____//.//   /__/__/ (_)      /  ||=|=|=|".colorize(:cyan)
puts  "__|  \/\|/   /(____|/ //                    /  /||~|~|~|__".colorize(:cyan)
puts   " |___\_/   /________//   ________         /  / ||_|_|_|".colorize(:cyan)
puts   " |___ /   (|________/   |\_______\       /  /| |______|".colorize(:cyan)
puts    "    /                  \|________)     /  / | |".colorize(:cyan)  
puts    "------------------------------------------------".colorize(:cyan)

puts   "~*~*~*~*~*~~*WELCOME TO HARRY POTTER READS*~*~*~*~~*~*~*~".colorize(:green)
pause
s_help(5)
  
end


    
    def menu_screen
    system('clear')

    s_help(5)
    puts "                                               _______________________________________".colorize(:cyan).bold
    s_help(3)
    puts  "                                                            Main Menu                ".colorize(:green).bold.italic
    s_help(2)
    puts  "                                                      1. Look up book author".colorize(:blue).bold
    puts  "                                                   2. Look up a list of authors".colorize(:blue).bold
    puts  "                                                      3. Look up your reviews".colorize(:blue).bold
    puts  "                                                      4. Look up book reviews".colorize(:blue).bold
    puts  "                                                      5. Make a book review".colorize(:blue).bold
    puts  "                                                     6. Look up book ratings".colorize(:blue).bold
    puts  "                                                7. Get a list of Harry Potter books".colorize(:blue).bold
    puts  "                                                     8. Update Your Reviews".colorize(:blue).bold
    puts  "                                                        9. Delete A Review".colorize(:blue).bold
    puts "                                              To leave the wizarding world, type 'exit'!".colorize(:blue).bold
    s_help(3)
    puts "                                              _______________________________________".colorize(:cyan).bold
    s_help(5)
    end

    # menu_screen

    def create_user_name
        puts "Please enter your username:".colorize(:light_blue)
        name = get.gsub(/[^a-z]/i, '').downcase.capitalize
        new_user = User.find_or_create_by(name: name)
        s_help(5)
       puts "~_~_~Welcome #{name}!~_~_~".blue.on_cyan.bold.blink

       s_help(5)
       pause
    end


    def list_books
        # puts "Here's a list of Harry Potter books!"
        s_help(3)
        books = Book.all.each{|book|p "#{book.id} #{book.title}"}
        # binding.pry
    end

    def book_by_name(id)
        titles = Book.all.map{|book| p "#{book.title} by #{book.author}" if book.id == id}

    end

    def list_authors
        s_help(2)
        puts "Here's a list authors!".colorize(:light_magenta).bold
        authors = Book.all.each{|book|p "#{book.id} #{book.author}"}
    end

    def list_review_by_book(book_num)
        #retrieve book instance
        #match it with review
        #return all reviews for that book
        reviews = Review.where(book_id: book_num)
        rev = reviews.map { |review|
            username = User.find(review.user_id).name
            "#{username}: " "#{review.message} " "Rating: #{review.rating}".colorize(:yellow).bold
        }.uniq

        puts rev
        # binding.pry
    end

    def make_new_reviews
        #take in user instance
        #take in book instance
        puts "Please enter your username".colorize(:blue).bold
        username = get.gsub(/[^a-z]/i, '').downcase.capitalize
        user = User.find_by(name: username).id
        # binding.pry
        list_books
        puts "Please enter the number corresponding to the book you want to make a review of.".colorize(:blue).bold
        books = get
        book = Book.find_by(id: books).id
        puts "Please give a rating between 1-5. 1 as poor and 5 as best.".colorize(:blue).bold
        rate = get
        puts "Any comments on the book? If none, please type 'none'.".colorize(:blue).bold
        comment = get
        
        new_review = Review.create(user_id: user, book_id: book, rating: rate, message: comment)

        # binding.pry
    end

    def average_rating(num)
        ratings = Review.where(book_id: num)
        array_rating = ratings.map{|review| review.rating}.reduce(:+).to_f 
        rating_length = ratings.map {|review| review.rating}.count.to_f
        if rating_length == 0
            return puts "No reviews found :("
        else  ar = array_rating/rating_length
                puts "Averating Book Rating: #{ar}".colorize(:green)
        end
        # binding.pry
    end


    def book_ratings(num)
        # ratings = Review.where(book_id: num)
        ratings = Review.where(book_id: num)

        # binding.pry
        ratings.map { |review|
        username = User.find(review.user_id).name
        puts "#{username}: Rating: #{review.rating}".colorize(:blue)
    }.uniq
        # binding.pry
        average_rating(num)
    end

    def list_user_review(name)
        puts "Here's your list of reviews #{name}!".colorize(:green).bold
        s_help(1)
        current_user = User.where(name: name)
        user_reviews = Review.where(user_id: current_user[0].id)
        user_reviews.each {|review| puts "Review #:#{review.id}. #{review.message}".colorize(:light_green)}
        
        # Review.all.each {|review| puts "#{review.id}. #{review.message}"}
        
        # user_review_instance = Review.all.each{|review| review.user_id == current_user}
        # user_review_instance.map {|review| 
        # book_name = Book.find(review.book_id).title
        # "#{review.book_id}. #{book_name} 
        # Rating: #{review.rating} " "#{review.message}"}

    end
    def delete_review
        #find specific review instance
        #then delete that reviews
        puts "Please enter the review number that you want to delete"
        review_number = get
        review = Review.find_by(id: review_number)
        # binding.pry
        review.destroy
        # binding.pry
        
    end
    def update_review
        puts "Please enter the review number that you want to update"
        review_number = get
        review = Review.find_by(id: review_number)
        # binding.pry
        puts "Please type up an update review for this review"
        u_message = get
        # binding.pry
        review.update(message: u_message)
        # binding.pry
    end
    def pause 
        puts "Press any letter or number to continue...."
        STDIN.getch
    end
    def exit_run
        puts "Goodbye!"
    puts "     __"
    puts "   _|==|_ " 
    puts "    ('')___/"
    puts ">--(`^^')"
    puts "  (`^'^'`)"
    puts "  `======' "

    end


    def run
        loop do
        menu_screen
        command = ""
        
        puts "Please enter command number or 'exit':"
        command = get.strip.to_s
        
        case command
        when "1"
            list_books
            s_help(2)
            puts "Type in the number corresponding to the book you would like to find the author for:".colorize(:light_blue).bold
            id = get.to_i
            s_help(2)
            book_by_name(id)
            pause
        when "2"
            list_authors
            pause
        when "3"
            s_help(2)
            puts "Please enter your username".colorize(:blue).bold
            name = get.gsub(/[^a-z]/i, '').downcase.capitalize
            s_help(2)
            list_user_review(name)
            pause
        when "4"
            list_books
            puts "Please enter the number corresponding with the book title.".colorize(:red).bold
            book_num = get
            s_help(2)
            list_review_by_book(book_num)
            pause
        when "5"
            make_new_reviews
            pause
        when "6"
            list_books
            puts "Please enter the number corresponding to the book.".colorize(:cyan).bold
            num = get.to_i
            book_ratings(num)
            pause
        when "7"
            list_books
            pause
        when "8"
            s_help(2)
            puts "Please enter your username".colorize(:blue).bold
            name = get.gsub(/[^a-z]/i, '').downcase.capitalize
            s_help(2)
            list_user_review(name)
            update_review
            pause
        when "9"
            s_help(2)
            puts "Please enter your username".colorize(:blue).bold
            name = get.gsub(/[^a-z]/i, '').downcase.capitalize
            s_help(2)
            list_user_review(name)
            delete_review
            pause
        when "exit"
            exit_run
            break if command == "exit"
        else
            puts "Invalid input. Please try again."
            pause
        end
    end


    end





# end

