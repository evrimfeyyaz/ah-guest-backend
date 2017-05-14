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

# Create room service item attributes.
RoomService::ItemAttribute.destroy_all
cereals_attribute = RoomService::ItemAttribute.create!(title: 'Cereals')
seafood_attribute = RoomService::ItemAttribute.create!(title: 'Seafood')
dairy_attribute = RoomService::ItemAttribute.create!(title: 'Dairy')
nuts_and_seeds_attribute = RoomService::ItemAttribute.create!(title: 'Nuts & Seeds')
egg_attribute = RoomService::ItemAttribute.create!(title: 'Egg')
mustard_and_celery_attribute = RoomService::ItemAttribute.create!(title: 'Mustard & Celery')
soya_attribute = RoomService::ItemAttribute.create!(title: 'Soya')
spicy_attribute = RoomService::ItemAttribute.create!(title: 'Spicy')
healthy_attribute = RoomService::ItemAttribute.create!(title: 'Healthy')
vegetarian_attribute = RoomService::ItemAttribute.create!(title: 'Vegetarian')
puts "Created #{RoomService::ItemAttribute.count} room service item attributes."

# Create room service item options.
RoomService::ItemOption.destroy_all
breakfast_beverage_option = RoomService::ItemOption.create!(title: 'Beverage', optional: false, allows_multiple_choices: false)
breakfast_beverage_option.possible_choices.create!([
  { title: 'Tea', price: 0 },
  { title: 'Coffee', price: 0 },
  { title: 'Milk', price: 0 }
                                                  ])
breakfast_pastry_option = RoomService::ItemOption.create!(title: 'Pastries', optional: false, allows_multiple_choices: false)
breakfast_pastry_option.possible_choices.create!([
  { title: "Baker's Basket", price: 0 },
  { title: 'Bread rolls', price: 0 }
                                                ])
puts "Created #{RoomService::ItemOption.count} room service item options."
puts "Created #{RoomService::ItemOptionChoice.count} room service item option choices."

# Create room service items.
breakfast_category = RoomService::Category.find_by(title: 'Breakfast')
breakfast_category.default_section.items.create(title: 'Continental Breakfast', price: 6.000, item_attributes: [dairy_attribute],
                                                long_description: 'fusion selection of tea, coffee or milk, choice of fresh seasonal juice, baker’s basket with toast, croissant, Danish or bread rolls with butter, honey, jam or marmalade',
                                                possible_options: [breakfast_beverage_option, breakfast_pastry_option])
breakfast_category.default_section.items.create(title: 'American Breakfast', price: 8.500, item_attributes: [dairy_attribute])
breakfast_category.default_section.items.create(title: 'Oriental Breakfast', price: 8.500, item_attributes: [dairy_attribute])
breakfast_category.default_section.items.create(title: 'The K Healthy Breakfast', price: 8.500, item_attributes: [dairy_attribute, healthy_attribute])
puts "Created #{breakfast_category.default_section.items.count} items in the '#{breakfast_category.default_section.title}' section of the '#{breakfast_category.title}' category."