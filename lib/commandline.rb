#require 'pry'
#define "run" command

#bin.run.rb

#cli = CommandLine.new
#cli.welcome
#system('clear')


#class Commandline
  # def run
  # end

    system('clear')

    def get_user_method
      user_name = gets.strip
      current_person = Member.all.select {|member| member.name == user_name}
      return current_person[0]
    end

    def say_hello
      puts "                      _                                                    "
      puts "                    _(_)_                                 wWWWw     _      "
      puts "      @@@@        (_)@(_)     vVVVv        _      @@@@    (___)   _(_)_    "
      puts "     @@()@@  wWWWw  (_)\      (___)      _(_)_   @@()@@     Y    (_)@(_)   "
      puts "      @@@@   (___)     `|/      Y       (_)@(_)   @@@@     \|/     (_)\    "
      puts "       /       Y       \|      \|/       /(_)     \|        |/      |      "
      puts "     \ |     \ |/       | /   \ | /     \|/         |/      \|      \|/     "
      puts "     \\|//   \\|///  \\\|//  \\\|///     \|///    \\\|//    \\|//  \\\|//    " 
      puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      puts "Hello!" 
      puts "Welcome to your Community Gardens Assistant."
      puts "Please type your first name."
    end

    def greet_user(current_user)
        puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
        puts ""
        puts ""
        puts "Hello #{current_user.name}!"
        puts ""

    end  

    def back_to_main(current_user)
    puts "Back to Main Menu? y/n"
            user_input = gets.strip
            if user_input = "y" 
          puts ""
          menu(current_user)
            else user_input = "n"
              exit_garden
            end
    end

    def menu(current_user)
      menu_options = [
      "View a list of nearby community gardens in Seattle, WA",
      "View a list of your plants and their heights",
      "Water your plants",
      "Plant a new plant",
      "Remove a plant",
      "Exit"
    ]
    puts "[::MAIN MENU::]"
    puts "Please choose an option below:"
    puts ""
      menu_options.each_with_index do |option, i|
        puts "(#{i + 1}) #{option}"
      end
      puts ""
      puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      menu_option = gets.strip
      case menu_option
        when "1"
          view_gardens
          puts ""
          puts ""
          back_to_main(current_user)
          puts ""
        when "2"
          view_plants(current_user)
          puts ""
          puts ""
          back_to_main(current_user)
          puts ""
        when "3"
          water_plants(current_user)
          puts ""
          puts ""
          # menu(current_user)
        when "4"
          new_plant(current_user)
          puts ""
          puts ""
          back_to_main(current_user)
          puts ""
        when "5"
          remove_plant(current_user)
          puts ""
          puts ""
          back_to_main(current_user)
          puts ""
        when "6"
          exit_garden
        else
        puts "[::TRY AGAIN::]"
        puts "That's not an option. Please pick again."
        puts ""
        menu
        
      end
    end

    # def view_members

    #   puts "--- What is your name?: ---"
    #   puts ""
    #   Member.all.each_with_index do |member, i|
    #     puts "(#{i + 1}) #{member.name}"
    #   end
    #   puts ""
    #   puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    # end


    def view_gardens
      #View a list of nearby community gardens and their locations
      
      # Garden.all.map  do |garden, i| 
      #   puts "#{i + 1}) #{garden.name} in #{garden.location}."
      # end
      puts ""
      puts "[::Nearby Community Gardens::]"
      puts ""
      Garden.all.map do |garden| puts "---> #{garden.name.upcase} located in #{garden.location}."
      puts ""
      end
    end

    def view_plants(current_user)
      #View your current list of your plants and their locations
      #Plant.all.select {|plant| plant.common_name == (self)}
     
      # member = (member_id: Member.find_by(name: name).id) 
      # Plant.find_all_by(member)
      puts ""
      puts "Your Plants:"
      puts ""
        users_plants = Plant.where(member_id: current_user.id)

        users_plants.all.each_with_index do |plant, i|
        
        puts "---> #{plant.common_name} is #{plant.height} inches tall!"


      end
    end

    def get_plant_by_name(current_user, common_name)
      desired_plant = Plant.find_by(common_name: common_name, member_id: current_user.id)
      desired_plant
    end

    def plant_growth(plant_to_water)
      puts ""
      puts "Thanks for the H2O! Your plant just grew 0.25 inches! :) "
      
      current_height = plant_to_water['height']
      new_height = current_height + 0.25

      plant_to_water.update(height: new_height)
      puts ""
      puts "Your #{plant_to_water.common_name} is now #{plant_to_water.height} inches tall!"
    end

    def water_plants(current_user)
      #Water your plants
      puts ""
      puts "[::WATER PLANTS::]"
      puts "Which plant would you like to water? Select by plant name."
      puts ""
      view_plants(current_user)

      plant_common_name = gets.strip
      #user selects which plant
      desired_plant = get_plant_by_name(current_user, plant_common_name)
      plant_growth(desired_plant)

    end

   
    def remove_plant(current_user)

      #Delete a plant
      puts ""
      puts "[::REMOVE PLANT::]"
      puts "Which plant would you like to remove? Select by plant name."
      puts ""
      view_plants(current_user)

      plant_common_name = gets.strip

      #user selects which plant to remove
      desired_plant = get_plant_by_name(current_user, plant_common_name)
      desired_plant.destroy
      puts ""
      puts "Your #{plant_common_name} has killed itself."

    end

    #which garden would you like it in? get garden_id likc common name
    
    def get_garden_choice(current_user)
    end


    def new_plant(current_user)
      #Plant a new plant
      new_plant = Plant.create(common_name: "Kale", member_id: current_user.id, garden_id: 2, height: 9.0)
      #which garden would you like it in? get garden_id likc common name
      
    end


    def exit_garden
      puts "Goodbye! Your plants will miss you."
    end


    # def run(menu_options)
      
    # end


  


  

  # def help

  # end

 # Menu
  # 1. View a list of all gardens 
  # 2. Visit a specific garden
  # 3. Check on your plants (view your plants, check the heights of each plant)
  # 4. Water your plants (height = +1), can only do this once in a 24hr time period
  # 5. Plant a new plant (common name, member_id, garden_id, height)



  # def exit
  #   puts "Goodbye! Come back soon, your plants will miss you!"
  # end

  # help, things you can do
  # - Check out all of the community gardens near you
  # - Visit a garden to view the plants that you have there
  # - Check on your plants and water them, check their height after!
  # - Plant a new plant at your favorite garden!