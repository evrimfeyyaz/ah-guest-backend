RoomService::Category.destroy_all
RoomService::Category.create!([{
  title: "Breakfast",
  description: "Served from 6am to 11am",
  image: Rails.root.join('seed/breakfast.jpg').open
                              }, {
  title: "Breakfast A La Carte",
  description: "Served from 6am to 11am",
  image: Rails.root.join('seed/breakfast-a-la-carte.jpg').open
                              }, {
  title: "Starters and Salads",
  image: Rails.root.join('seed/starters-and-salads.jpg').open
                              }, {
  title: "Arabic Mezzeh Selection"
                              }, {
  title: "Homemade Soups",
  image: Rails.root.join('seed/homemade-soups.jpg').open
                              }, {
  title: "Main Fares"
                              }, {
  title: "From The Grill",
  image: Rails.root.join('seed/from-the-grill.jpg').open
                              }, {
  title: "Pasta",
  image: Rails.root.join('seed/pasta.jpg').open
                              }, {
  title: "Pizza Corner",
  image: Rails.root.join('seed/pizza-corner.jpg').open
                              }, {
  title: "Burgers & Wraps",
  image: Rails.root.join('seed/burgers-and-wraps.jpg').open
                              }, {
  title: "Kids Choice"
                              }, {
  title: "Our Pastry Chef's Delights",
  image: Rails.root.join('seed/our-pastry-chefs-delights.jpg').open
                              }, {
  title: "Round O'Clock Menu - 24/7",
  image: Rails.root.join('seed/round-o-clock-menu-24-7.jpg').open
                              }, {
  title: "Beverages Hot & Cold",
  description: "Available 24 hours",
  image: Rails.root.join('seed/beverages-hot-and-cold.jpg').open
                              }
])
puts "Created #{RoomService::Category.count} room service categories."

breakfast_category = RoomService::Category.find_by(title: 'Breakfast')
breakfast_category.default_section.items.create(title: 'Continental Breakfast', price: 6.000)
breakfast_category.default_section.items.create(title: 'American Breakfast', price: 8.500)
breakfast_category.default_section.items.create(title: 'Oriental Breakfast', price: 8.500)
breakfast_category.default_section.items.create(title: 'The K Healthy Breakfast', price: 8.500)
puts "Created #{breakfast_category.default_section.items.count} items in the '#{breakfast_category.default_section.title}' section of the '#{breakfast_category.title}' category."