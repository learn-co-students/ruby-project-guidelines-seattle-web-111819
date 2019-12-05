require_relative '../config/environment'
ActiveRecord::Base.logger = nil


say_hello
CURRENT_USER = get_user_method
greet_user(CURRENT_USER)

menu(CURRENT_USER)




puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"


