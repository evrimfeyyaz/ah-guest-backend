# Create room service categories.
RoomService::Category.destroy_all
RoomService::Category.create!([
                                {
                                  title: 'Breakfast',
                                  description: 'Served from 6am to 11am',
                                  image: Rails.root.join('seed/breakfast.jpg').open
                                }, {
                                  title: 'Main Fares',
                                  image: Rails.root.join('seed/from-the-grill.jpg').open
                                }, {
                                  title: "Our Pastry Chef's Delights",
                                  image: Rails.root.join('seed/our-pastry-chefs-delights.jpg').open
                                }, {
                                  title: 'Beverages Hot & Cold',
                                  description: 'Available 24/7',
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

RoomService::ItemChoice.destroy_all
# Create room service item choices for breakfast items.
breakfast_beverage_choice = RoomService::ItemChoice.create!(title: 'Beverage', optional: false, allows_multiple_options: false)
breakfast_beverage_choice.options.create!([
                                            { title: 'Tea', price: 0 },
                                            { title: 'Coffee', price: 0 },
                                            { title: 'Milk', price: 0 }
                                          ])
breakfast_pastry_choice = RoomService::ItemChoice.create!(title: 'Pastries', optional: false, allows_multiple_options: false)
breakfast_pastry_choice.options.create!([
                                          { title: "Baker's Basket", price: 0 },
                                          { title: 'Bread rolls', price: 0 }
                                        ])

breakfast_beverage_choice_with_decaf= RoomService::ItemChoice.create!(title: 'Beverage', optional: false, allows_multiple_options: false)
breakfast_beverage_choice_with_decaf.options.create!([
                                                       { title: 'Tea', price: 0 },
                                                       { title: 'Coffee', price: 0 },
                                                       { title: 'Coffee (de-caffeinated', price: 0 },
                                                       { title: 'Milk', price: 0 }
                                                     ])

# Create room service items.
breakfast_category = RoomService::Category.find_by(title: 'Breakfast')
breakfast_category.default_sub_category.items.create!(title: 'Continental Breakfast', price: 6.000, tags: [dairy_tag],
                                                     description: 'Fusion selection of tea, coffee or milk, choice of fresh seasonal juice, baker’s basket with toast, croissant, Danish or bread rolls with butter, honey, jam or marmalade.',
                                                     choices: [breakfast_beverage_choice, breakfast_pastry_choice])
breakfast_category.default_sub_category.items.create!(title: 'American Breakfast', price: 8.500, tags: [dairy_tag],
                                                     description: 'Fusion selection of tea, coffee or milk, choice of fresh seasonal juice, baker’s basket with toast, two eggs, sausages, veal bacon, hash brown potatoes, baked beans and toasted bread.',
                                                     choices: [breakfast_beverage_choice])
breakfast_category.default_sub_category.items.create!(title: 'Oriental Breakfast', price: 8.500, tags: [dairy_tag],
                                                     description: 'Fusion selection of tea, coffee or milk, choice of fresh seasonal juice, baker’s basket with toast, ful medames served with tomatoes and onions, feta cheese, labneh with olive oil, two eggs, assorted vegetables, olives and Lebanese bread.',
                                                     choices: [breakfast_beverage_choice])
breakfast_category.default_sub_category.items.create!(title: 'The K Healthy Breakfast', price: 8.500, tags: [dairy_tag, healthy_tag],
                                                     description: 'Fusion selection of tea, coffee (de-caffeinated) or milk, choice of fresh seasonal juice, baker’s basket with toast, two boiled or poached eggs, diet labneh, low fat spread cheese, toasted brown bread, cucumbers, tomatoes and lettuce.',
                                                     choices: [breakfast_beverage_choice_with_decaf])

puts "Created #{breakfast_category.default_sub_category.items.count} items in the '#{breakfast_category.default_sub_category.title}' sub-category of the '#{breakfast_category.title}' category."

# Create room service item choices for main fares.
meat_choice = RoomService::ItemChoice.create!(title: 'Meat', optional: false, allows_multiple_options: false)
meat_choice.options.create!([
                              { title: 'Chicken', price: 0 },
                              { title: 'Lamb', price: 0 }
                            ])

# Create room service items for main fares.
main_fares_category = RoomService::Category.find_by(title: 'Main Fares')
main_fares_category.default_sub_category.items.create!(title: 'Spinach, Mushroom and Artichoke Lasagne', price: 3.600, tags: [vegetarian_tag, dairy_tag, egg_tag],
                                                      description: 'Creamy layered vegetables, tomato sauce, and topped with basil and curled peppers.')
main_fares_category.default_sub_category.items.create!(title: 'Malay Vegetable Curry', price: 2.800, tags: [vegetarian_tag, spicy_tag],
                                                      description: 'Eggplants, carrots, green beans, baby marrows and potatoes in a spicy coconut sauce Malaysian style.')
main_fares_category.default_sub_category.items.create!(title: 'Thai Chicken Curry', price: 3.800, tags: [dairy_tag],
                                                      description: 'Lemon grass, coconut milk, spices, cherry tomatoes, Thai eggplants served with spicy onion-tomato sambal and coconut rice.')
main_fares_category.default_sub_category.items.create!(title: 'Chicken “Cordon Bleu”', price: 4.200, tags: [dairy_tag, healthy_tag],
                                                      description: 'Breaded chicken breast, stuffed with smoked turkey and cheese accompanied by French fries.')
main_fares_category.default_sub_category.items.create!(title: 'Traditional Biryani (Raita and Garnish)', price: 4.200, tags: [dairy_tag, nuts_and_seeds_tag, egg_tag],
                                                      description: 'Traditional Indian style biryani rice with chicken or lamb meat served with cucumber-yoghurt raita and poppadom.',
                                                      choices: [meat_choice])

puts "Created #{main_fares_category.default_sub_category.items.count} items in the '#{main_fares_category.default_sub_category.title}' sub-category of the '#{main_fares_category.title}' category."

# Create room service items for pastries.
pastries_category = RoomService::Category.find_by(title: "Our Pastry Chef's Delights")
pastries_category.default_sub_category.items.create!(title: 'Classic Crème Brûlée', price: 2.500, tags: [dairy_tag, egg_tag],
                                                      description: 'Tahitian vanilla beans, served with crème fraîche ice cream.')
pastries_category.default_sub_category.items.create!(title: '“New York” Cheesecake', price: 3.000, tags: [dairy_tag, egg_tag, nuts_and_seeds_tag],
                                                      description: 'Topped with blueberries.')
pastries_category.default_sub_category.items.create!(title: 'Tiramisu', price: 3.000, tags: [dairy_tag],
                                                      description: 'Italian classic layered coffee infused sponge and light mascarpone custard.')
pastries_category.default_sub_category.items.create!(title: 'Assorted Fresh Fruits', price: 2.500, tags: [healthy_tag],
                                                      description: 'Our daily selection of fruit cuts infused with orange and mint syrup.')
pastries_category.default_sub_category.items.create!(title: 'Assorted Cheese Platter', price: 4.800, tags: [dairy_tag, nuts_and_seeds_tag, egg_tag],
                                                      description: 'Served with pepper spiced pear marmalade, grapes, nuts and crackers.')

puts "Created #{pastries_category.default_sub_category.items.count} items in the '#{pastries_category.default_sub_category.title}' sub-category of the '#{pastries_category.title}' category."

# Create room service items for pastries.
beverages_category = RoomService::Category.find_by(title: 'Beverages Hot & Cold')
hot_beverages_sub_category = RoomService::SubCategory.create!(category: beverages_category, title: 'Hot Beverages')
cold_beverages_sub_category = RoomService::SubCategory.create!(category: beverages_category, title: 'Cold Beverages')
hot_beverages_sub_category.items.create!(title: 'Tea Selection', price: 1.800)
hot_beverages_sub_category.items.create!(title: 'American Coffee', price: 1.800)
hot_beverages_sub_category.items.create!(title: 'Espresso', price: 2.200)
hot_beverages_sub_category.items.create!(title: 'Espresso Double', price: 3.100)
cold_beverages_sub_category.items.create!(title: 'Coca Cola 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Coca Cola Diet 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Sprite 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Fresh Orange Juice 300ml', price: 2.500)

puts "Created #{beverages_category.default_sub_category.items.count} items in the '#{beverages_category.default_sub_category.title}' sub-category of the '#{beverages_category.title}' category."

puts "Created #{RoomService::ItemChoice.count} room service item choices."
puts "Created #{RoomService::ItemChoiceOption.count} room service item choice options."