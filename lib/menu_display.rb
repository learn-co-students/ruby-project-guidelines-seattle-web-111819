# menu spacing values global variable
$sp = {t: 5, l: 10, w: 80}

# Displays the menu header
def display_menu_header(header, user="guest")
    user == "guest" ? username = "User: guest" : username = "User: " + user.name
    system('clear')
    puts "\n" * $sp[:t]
    puts " " * ($sp[:l] + $sp[:w] - username.size) + username
    header.each {|line| puts " " * $sp[:l] + line}
    puts " " * $sp[:l] + "-" * $sp[:w]
end

# Displays the menu body for multi-option menus
# Validates and returns the input
def display_options_menu(options, message)
    optnums = (1..options.count).map{ |i| i.to_s 36}
    options.each_with_index {|opt, i| puts " " * $sp[:l] + "|  #{optnums[i]}) #{opt[0]}" + " " * ($sp[:w] - 7 - opt[0].size) + "|"}
    puts " " * $sp[:l] + "-" * $sp[:w]
    puts "\n" * (4 - message.count)
    message.each {|line| puts " " * $sp[:l] + line}
    print "\n" + " " * $sp[:l] + "Your selection (1-#{optnums[-1]})?  "
    input = STDIN.getch
    exit_game_reviews if input.ord == 27
    optnums.include?(input) ? options[optnums.index(input)][1] : nil
end

# Displays the menu body for string requests
# Returns the input
def display_string_menu(prompt, message)
    puts "\n" * (3 - message.count)
    message.each {|line| puts " " * $sp[:l] + line}
    prompt.each {|line| print "\n" + " " * $sp[:l] + line}
    input = gets.strip
end

# Displays the menu footer
# Pauses the screen
def display_footer(message)
    puts "\n\n"
    message.each {|line| puts " " * $sp[:l] + line}
    print " " * $sp[:l] + "Press any key to continue...  "
    STDIN.getch
    puts ""
end