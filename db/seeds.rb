# require 'pry'
# binding.pry

alice = Member.create(name:"Alice", years_experience: 10)
kevin = Member.create(name:"Kevin", years_experience: 6)
meg = Member.create(name:"Meg", years_experience: 9)
oliver = Member.create(name:"Oliver", years_experience: 8)
jessica = Member.create(name:"Jessica", years_experience:14)

seattle_garden = Garden.create(name: "Seattle Community Garden", location: "Seattle")
renton_garden = Garden.create(name: "Queen Anne Community Garden", location: "Queen Anne")
qa_garden = Garden.create(name: "Renton Community Garden", location: "Renton")
bee_garden = Garden.create(name: "Bees Community Garden", location: "Ballard")

plant1 = Plant.create(common_name: "Rose", member_id: 1, garden_id: 1, height: 7.0)
plant2 = Plant.create(common_name: "Tulip", member_id: 2, garden_id: 2, height: 5.0)
plant3 = Plant.create(common_name: "Tomato", member_id: 3, garden_id: 3, height: 2.0)
plant4 = Plant.create(common_name: "Rosemary", member_id: 4, garden_id: 4, height: 6.0)
plant5 = Plant.create(common_name: "Dahlia", member_id: 5, garden_id: 1, height: 7.5)
plant6 = Plant.create(common_name: "Kale", member_id: 1, garden_id: 2, height: 9.0)
plant7 = Plant.create(common_name: "Sunflower", member_id: 2, garden_id: 3, height: 20.5)
plant8 = Plant.create(common_name: "Strawberry", member_id: 3, garden_id: 4, height: 4.0)
plant9 = Plant.create(common_name: "Tomato", member_id: 4, garden_id: 1, height: 2.0)
plant10 = Plant.create(common_name: "Rose", member_id: 5, garden_id: 2, height: 7.0)


# plant.each do |plant|
#   Plant.create(plant: plant[:common_name], owner: plant[:owner])
# end