# Routing between menus
# Includes a tracer for the previous menu
def menu_routing(user, game, router, tracer=2)
    exit_game_reviews if router == 1
    main_menu(user) if router == 2
    login if router == 3
    logout(user) if router == 4
    create_account if router == 5
    my_account(user) if router == 6
    delete_account(user) if router == 7
    choose_game(user) if router == 8
    game_reviews(user, game, tracer) if router == 9
    write_review(user, game, tracer) if router == 10
    update_review(user, game, tracer) if router == 11
    change_name(user) if router == 12
    my_reviews(user, tracer) if router == 13
    choose_game(user) if router == 14
    game_menu(user, game, tracer) if router == 15
    update_review_rating(user, game, tracer) if router == 16
    update_review_text(user, game, tracer) if router == 17
    delete_review(user, game, tracer) if router == 18
    read_review(user, game, Review.find(router / 100), tracer) if router > 99
end