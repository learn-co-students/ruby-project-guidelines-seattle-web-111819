

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
      puts "Welcome to your Community Gardens App."
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
          system('clear')
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
    puts ""
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
          back_to_main(current_user)
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
        puts ""
        puts "That's not an option. Please pick again."
        puts ""

        menu
        
      end
    end


#-----R E A D   M E T H O D S --------------------------------------------------------------

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
      puts "[::YOUR PLANTS::]"
      puts ""
        users_plants = Plant.where(member_id: current_user.id)

        users_plants.all.each_with_index do |plant, i|
        
        puts "---> #{plant.common_name} is #{plant.height} inches tall!"

        #returns a string (not an object) using plant's attributes.
      end
    end

#----- U P D A T E   M E T H O D  -----------------------------------------------------

    def get_plant_by_name(current_user, common_name)
      #helper method

      desired_plant = Plant.find_by(common_name: common_name, member_id: current_user.id)
      desired_plant

      #saves the selected plant and current user to a variable to be passed into water_plants , and then into plant_to_water
    end

    def plant_growth(plant_to_water)
      #helper method to water_plants, updates height of plant

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
      puts ""
      puts "Which plant would you like to water? Select by plant name."
      puts ""
      view_plants(current_user)

      plant_common_name = gets.strip

      #user selects which plant
      desired_plant = get_plant_by_name(current_user, plant_common_name)

      plant_growth(desired_plant)

    end



#----- C R E A T E   M E T H O D -------------------------------------------------------
    
#2
    def get_garden_by_id(current_user)
    #get selection of garden by matching name to name in indexed list
      garden_choice = garden_choices(current_user)
      Garden.find_by(name: garden_choice).id
    end

#1
    def garden_choices(current_user)

      puts "[::PLANT SOMETHING SOMEWHERE::]"
      puts ""
      puts "Let's plant a new plant! Which garden would you like to add this plant to? Please pick by Garden Name:"
      puts ""
      #show list of gardens 
      Garden.all.map do |garden, i| puts "#{garden.name.upcase} located in #{garden.location}."

      end
      #user selects which garden
      selected_garden = gets.strip.downcase
      
    end


#3    
    def new_plant(current_user)

      puts ""
      puts ""
      garden_id_choice = get_garden_by_id(current_user)
      puts ""
      puts "What should we call your plant?"
      
      #user types plant name
      plant_common_name = gets.strip.downcase
      
      #create the new plant using passed in parameters
      new_plant = Plant.create(common_name: plant_common_name, member_id: current_user.id, garden_id: garden_id_choice, height: 5.0)
      new_plant

      puts "Yay! Your new plant, #{plant_common_name} has been added!"

      puts"           _ _         "
      puts"         _{ ' }_       "
      puts"        { `.!.` }      "
      puts"        ',_/Y\_,'      "
      puts"          {_,_}        "
      puts"            |          "
      puts"          (\|  /)      "
      puts"           \| //       "
      puts"            |//        "
      puts"         \\ |/  //     "
      puts"      ^^^^^^^^^^^^^^^  "

    end




    #----- D E L E T E   M E T H O D ------------------------------------------------------
   
    def remove_plant(current_user)

      #Delete a plant
      puts ""
      puts "[::REMOVE PLANT::]"
      puts ""
      puts "Which plant would you like to remove? Select by plant name."
      puts ""
      view_plants(current_user)

      plant_common_name = gets.strip

      #user selects which plant to remove
      desired_plant = get_plant_by_name(current_user, plant_common_name)
      desired_plant.destroy
      puts ""
      puts "Your #{plant_common_name} has died."

    end


  #------ E X I T ---------------------------------------------

    def exit_garden
      puts "[::BYE::]"
      puts ""
      puts "Goodbye! Your plants will miss you."
    end