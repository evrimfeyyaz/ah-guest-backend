# Create room service categories.
RoomService::Category.destroy_all
RoomService::Category.create!([
                                {
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
                                  title: "Kids ItemChoice"
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

# Create room service tags.
RoomService::Tag.destroy_all
cereals_tag = RoomService::Tag.create!(title: 'Cereals')
seafood_tag = RoomService::Tag.create!(title: 'Seafood')
dairy_tag = RoomService::Tag.create!(title: 'Dairy')
nuts_and_seeds_tag = RoomService::Tag.create!(title: 'Nuts & Seeds')
egg_tag = RoomService::Tag.create!(title: 'Egg')
mustard_and_celery_tag = RoomService::Tag.create!(title: 'Mustard & Celery')
soya_tag = RoomService::Tag.create!(title: 'Soya')
spicy_tag = RoomService::Tag.create!(title: 'Spicy')
healthy_tag = RoomService::Tag.create!(title: 'Healthy')
vegetarian_tag = RoomService::Tag.create!(title: 'Vegetarian')
puts "Created #{RoomService::Tag.count} room service item attributes."

# Create room service item options.
RoomService::ItemChoice.destroy_all
breakfast_beverage_option = RoomService::ItemChoice.create!(title: 'Beverage', optional: false, allows_multiple_choices: false)
breakfast_beverage_option.possible_choices.create!([
                                                     { title: 'Tea', price: 0 },
                                                     { title: 'Coffee', price: 0 },
                                                     { title: 'Milk', price: 0 }
                                                   ])
breakfast_pastry_option = RoomService::ItemChoice.create!(title: 'Pastries', optional: false, allows_multiple_choices: false)
breakfast_pastry_option.possible_choices.create!([
                                                   { title: "Baker's Basket", price: 0 },
                                                   { title: 'Bread rolls', price: 0 }
                                                 ])
puts "Created #{RoomService::ItemChoice.count} room service item options."
puts "Created #{RoomService::ItemChoiceOption.count} room service item option choices."

# Create room service items.
breakfast_category = RoomService::Category.find_by(title: 'Breakfast')
breakfast_category.default_section.items.create(title: 'Continental Breakfast', price: 6.000, tags: [dairy_tag],
                                                long_description: 'fusion selection of tea, coffee or milk, choice of fresh seasonal juice, baker’s basket with toast, croissant, Danish or bread rolls with butter, honey, jam or marmalade',
                                                options: [breakfast_beverage_option, breakfast_pastry_option])
breakfast_category.default_section.items.create(title: 'American Breakfast', price: 8.500, tags: [dairy_tag])
breakfast_category.default_section.items.create(title: 'Oriental Breakfast', price: 8.500, tags: [dairy_tag])
breakfast_category.default_section.items.create(title: 'The K Healthy Breakfast', price: 8.500, tags: [dairy_tag, healthy_tag])
puts "Created #{breakfast_category.default_section.items.count} items in the '#{breakfast_category.default_section.title}' section of the '#{breakfast_category.title}' category."