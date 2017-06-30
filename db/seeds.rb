# Create room service categories.
RoomService::Category.destroy_all

Time.use_zone('Riyadh') do
  RoomService::Category.create!([
                                  {
                                    title: 'Breakfast',
                                    description: 'Served from 6am to 11am',
                                    image: Rails.root.join('seed/breakfast.jpg').open,
                                    available_from: Time.parse('6am'),
                                    available_until: Time.parse('11am')
                                  }, {
                                    title: 'Breakfast A La Carte',
                                    description: 'Served from 6am to 11am',
                                    image: Rails.root.join('seed/breakfast-a-la-carte.jpg').open,
                                    available_from: Time.parse('6am'),
                                    available_until: Time.parse('11am')
                                  }, {
                                    title: 'Starters & Salads',
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/starters-and-salads.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: 'Arabic Mezzeh Selection',
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/arabic-mezzeh-selection.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: 'Homemade Soups',
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/homemade-soups.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: 'Main Fares',
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/main-fares.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: 'From the Grill',
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/from-the-grill.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: 'Pasta',
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/pasta.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: 'Pizza Corner',
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/pizza-corner.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: 'Burgers & Wraps',
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/burgers-and-wraps.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: 'Kids Choice',
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/kids-choice.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: "Our Pastry Chef's Delights",
                                    description: 'Served from 11am to 12am',
                                    image: Rails.root.join('seed/our-pastry-chefs-delights.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('12am')
                                  }, {
                                    title: "Round O'Clock Menu",
                                    description: 'Served 24/7',
                                    image: Rails.root.join('seed/round-o-clock-menu-24-7.jpg').open
                                  }, {
                                    title: 'Beverages Hot & Cold',
                                    description: 'Served 24/7',
                                    image: Rails.root.join('seed/beverages-hot-and-cold.jpg').open
                                  }, {
                                    title: 'Cocktails',
                                    description: 'Served from 11am to 2am',
                                    image: Rails.root.join('seed/cocktails.jpg').open,
                                    available_from: Time.parse('11am'),
                                    available_until: Time.parse('2am')
                                  }, {
                                    title: 'Mocktails',
                                    description: 'Served 24/7',
                                    image: Rails.root.join('seed/mocktails.jpg').open
                                  }
                                ])
  puts "Created #{RoomService::Category.count} room service categories."
end

# Create room service tags.
RoomService::Tag.destroy_all
cereals_tag = RoomService::Tag.create!(title: 'Cereals')
seafood_tag = RoomService::Tag.create!(title: 'Seafood')
dairy_tag = RoomService::Tag.create!(title: 'Dairy')
nuts_and_seeds_tag = RoomService::Tag.create!(title: 'Nuts & Seeds')
egg_tag = RoomService::Tag.create!(title: 'Eggs')
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
bakers_basket_choice = RoomService::ItemChoice.create!(title: "Baker's Basket", optional: false, allows_multiple_options: false)
bakers_basket_choice.options.create!([
                                       { title: "With Danish", price: 0 },
                                       { title: 'With bread rolls', price: 0 }
                                     ])

breakfast_beverage_choice_with_decaf = RoomService::ItemChoice.create!(title: 'Beverage', optional: false, allows_multiple_options: false)
breakfast_beverage_choice_with_decaf.options.create!([
                                                       { title: 'Tea', price: 0 },
                                                       { title: 'Coffee', price: 0 },
                                                       { title: 'Coffee (de-caffeinated', price: 0 },
                                                       { title: 'Milk', price: 0 }
                                                     ])

# Create room service items for breakfast.
breakfast_category = RoomService::Category.find_by(title: 'Breakfast')
breakfast_category.default_sub_category.items.create!(title: 'Continental Breakfast', price: 6.000, tags: [dairy_tag],
                                                      description: 'Fusion selection of tea, coffee or milk, choice of fresh seasonal juice, baker’s basket with toast, croissant, Danish or bread rolls with butter, honey, jam or marmalade.',
                                                      choices: [breakfast_beverage_choice, bakers_basket_choice])
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

# Create room service item choices for breakfast a la carte.
filling_choice = RoomService::ItemChoice.create!(title: 'Filling', optional: false, allows_multiple_options: false)
filling_choice.options.create!([
                                 { title: 'Cheese', price: 0 },
                                 { title: 'No filling', price: 0 }
                               ])

egg_style_choice = RoomService::ItemChoice.create!(title: 'Eggs', optional: false, allows_multiple_options: false)
egg_style_choice.options.create!([
                                   { title: 'Sunny side up', price: 0 },
                                   { title: 'Scrambled', price: 0 },
                                   { title: 'Hard boiled', price: 0 },
                                   { title: 'Soft boiled', price: 0 },
                                   { title: 'Poached', price: 0 },
                                   { title: 'Over easy', price: 0 },
                                   { title: 'Over medium', price: 0 },
                                   { title: 'Over hard', price: 0 }
                                 ])

cereal_choice = RoomService::ItemChoice.create!(title: 'Cereal', optional: false, allows_multiple_options: false)
cereal_choice.options.create!([
                                { title: 'Corn flakes', price: 0 },
                                { title: 'Rice Crisps', price: 0 },
                                { title: 'Frosties', price: 0 },
                                { title: 'All Bran', price: 0 },
                                { title: 'Weetabix', price: 0 },
                                { title: 'Bircher Müsli', price: 0 },
                                { title: 'Oatmeal', price: 0 }
                              ])

milk_choice = RoomService::ItemChoice.create!(title: 'Milk', optional: false, allows_multiple_options: false)
milk_choice.options.create!([
                              { title: 'Whole milk', price: 0 },
                              { title: 'Skim milk', price: 0 }
                            ])

# Create room service items for breakfast a la carte.
breakfast_a_la_carte_category = RoomService::Category.find_by(title: 'Breakfast A La Carte')
breakfast_a_la_carte_category.default_sub_category.items.create!(title: 'Spanish or Swiss', price: 3.000, tags: [],
                                                                 description: 'Cheese filling or plain, served with toasted bread and butter.',
                                                                 choices: [filling_choice])
breakfast_a_la_carte_category.default_sub_category.items.create!(title: 'Two Eggs Any Style', price: 3.500, tags: [egg_tag],
                                                                 description: 'With cheese, grilled beef bacon, breakfast potatoes and sausage.',
                                                                 choices: [egg_style_choice])
breakfast_a_la_carte_category.default_sub_category.items.create!(title: "Baker's Basket", price: 2.500, tags: [dairy_tag],
                                                                 description: 'Assortment of homemade croissants, Danish pastries, donuts, muffins and toasted bread, served with preserves and butter.',
                                                                 choices: [breakfast_beverage_choice])
breakfast_a_la_carte_category.default_sub_category.items.create!(title: 'Assorted Cereals', price: 2.000, tags: [dairy_tag, healthy_tag],
                                                                 description: 'Rice Crips, Frosties, All Bran, Weetabix, bircher müsli, oatmeal, served with your choice of whole or skimmed milk.',
                                                                 choices: [cereal_choice, milk_choice])
breakfast_a_la_carte_category.default_sub_category.items.create!(title: 'Fresh Fruit Cuts', price: 3.000, tags: [healthy_tag, vegetarian_tag],
                                                                 description: 'Seasonal and exotic fruit selection.',
                                                                 choices: [])

puts "Created #{breakfast_a_la_carte_category.default_sub_category.items.count} items in the '#{breakfast_a_la_carte_category.default_sub_category.title}' sub-category of the '#{breakfast_a_la_carte_category.title}' category."

# Create room service item choices for starters and salads.
chicken_or_prawn_choice = RoomService::ItemChoice.create!(title: 'Meat', optional: false, allows_multiple_options: false)
chicken_or_prawn_choice.options.create!([
                                          { title: 'Chicken', price: 0 },
                                          { title: 'Prawn', price: 0.500 }
                                        ])

# Create room service items for starters and salads.
starters_and_salads_category = RoomService::Category.find_by(title: 'Starters & Salads')
starters_and_salads_category.default_sub_category.items.create!(title: 'Prawn Tempura', price: 4.000, tags: [spicy_tag, seafood_tag, nuts_and_seeds_tag],
                                                                description: 'Green papaya salad, cashew nuts, chili and scallions.',
                                                                choices: [])
starters_and_salads_category.default_sub_category.items.create!(title: 'Caesar Salad', price: 4.500, tags: [dairy_tag, egg_tag],
                                                                description: 'Heart of romaine lettuce, creamy caesar dressing, croutons and parmesan shavings with cajun spiced chicken breast or with marinated grilled tiger prawns.',
                                                                choices: [chicken_or_prawn_choice])
starters_and_salads_category.default_sub_category.items.create!(title: 'Caprese Salad', price: 2.900, tags: [vegetarian_tag, dairy_tag, nuts_and_seeds_tag],
                                                                description: 'Buffalo mozzarella, vine ripened tomatoes, basil pesto, extra virgin olive oil, sweet balsamic reduction.',
                                                                choices: [])
starters_and_salads_category.default_sub_category.items.create!(title: 'Greek Salad', price: 3.000, tags: [vegetarian_tag, dairy_tag, healthy_tag, mustard_and_celery_tag],
                                                                description: 'Lettuce, bell peppers, cucumbers, tomatoes, feta cheese, red onions, olives, tossed in a light herb vinaigrette.',
                                                                choices: [])
starters_and_salads_category.default_sub_category.items.create!(title: 'Seared Tuna Salad Niçoise', price: 2.900, tags: [mustard_and_celery_tag, egg_tag, seafood_tag],
                                                                description: 'Green beans, hard-boiled egg, tomatoes, black olives, capers, herb roasted potatoes, served on a bed of lettuce.',
                                                                choices: [])

puts "Created #{starters_and_salads_category.default_sub_category.items.count} items in the '#{starters_and_salads_category.default_sub_category.title}' sub-category of the '#{starters_and_salads_category.title}' category."

# Create room service items for mezzehs.
arabic_mezzeh_selection_category = RoomService::Category.find_by(title: 'Arabic Mezzeh Selection')
arabic_mezzeh_selection_category.default_sub_category.items.create!(title: 'Hummus', price: 2.000, tags: [vegetarian_tag, nuts_and_seeds_tag],
                                                                    description: 'Chickpeas mousse with tahini, fresh lemon juice and garlic.',
                                                                    choices: [])
arabic_mezzeh_selection_category.default_sub_category.items.create!(title: 'Moutabel', price: 2.000, tags: [vegetarian_tag, healthy_tag, nuts_and_seeds_tag],
                                                                    description: 'Roasted eggplant pulp, mixed with sesame paste and seasoning.',
                                                                    choices: [])
arabic_mezzeh_selection_category.default_sub_category.items.create!(title: 'Tabouleh', price: 2.000, tags: [vegetarian_tag, healthy_tag],
                                                                    description: 'Finely chopped Arabic parsley combined with cracked wheat, lemon juice, garnished with tomatoes and onion cubes, spiced with sumac.',
                                                                    choices: [])
arabic_mezzeh_selection_category.default_sub_category.items.create!(title: 'Stuffed Vine Leaves', price: 2.000, tags: [vegetarian_tag],
                                                                    description: 'Pickled Lebanese vine leaves, stuffed with a mixture of rice, tomatoes and parsley.',
                                                                    choices: [])
arabic_mezzeh_selection_category.default_sub_category.items.create!(title: 'Kebbeh', price: 2.500, tags: [nuts_and_seeds_tag, cereals_tag],
                                                                    description: 'Minced lamb and cracked wheat, stuffed with minced burghol and spices.',
                                                                    choices: [])
arabic_mezzeh_selection_category.default_sub_category.items.create!(title: 'Arabian Mix Fatayer', price: 2.500, tags: [vegetarian_tag],
                                                                    description: 'Combination of cheese and spinach fatayer.',
                                                                    choices: [])

puts "Created #{arabic_mezzeh_selection_category.default_sub_category.items.count} items in the '#{arabic_mezzeh_selection_category.default_sub_category.title}' sub-category of the '#{arabic_mezzeh_selection_category.title}' category."

# Create room service items for homemade soups.
homemade_soups_category = RoomService::Category.find_by(title: 'Homemade Soups')
homemade_soups_category.default_sub_category.items.create!(title: 'Soup of the Day', price: 2.000, tags: [],
                                                           description: 'Please call us if you would like to find out today’s special.',
                                                           choices: [])
homemade_soups_category.default_sub_category.items.create!(title: 'Tom Ka Kai Soup', price: 2.500, tags: [spicy_tag],
                                                           description: 'Chicken, coconut milk, lemon grass and cilantro.',
                                                           choices: [])
homemade_soups_category.default_sub_category.items.create!(title: 'Cream of Mushroom Soup', price: 2.000, tags: [dairy_tag, vegetarian_tag, healthy_tag],
                                                           description: 'Blended white and shiitake mushrooms, topped with cream cheese and micro herbs.',
                                                           choices: [])

puts "Created #{homemade_soups_category.default_sub_category.items.count} items in the '#{homemade_soups_category.default_sub_category.title}' sub-category of the '#{homemade_soups_category.title}' category."

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
main_fares_category.default_sub_category.items.create!(title: 'Thai Chicken Curry', price: 3.800, tags: [spicy_tag],
                                                       description: 'Lemon grass, coconut milk, spices, cherry tomatoes, Thai eggplants served with spicy onion-tomato sambal and coconut rice.')
main_fares_category.default_sub_category.items.create!(title: 'Chicken “Cordon Bleu”', price: 4.200, tags: [dairy_tag, cereals_tag],
                                                       description: 'Breaded chicken breast, stuffed with smoked turkey and cheese accompanied by French fries.')
main_fares_category.default_sub_category.items.create!(title: 'Traditional Biryani (Raita and Garnish)', price: 4.200, tags: [dairy_tag, nuts_and_seeds_tag, egg_tag],
                                                       description: 'Traditional Indian style biryani rice with chicken or lamb meat served with cucumber-yoghurt raita and poppadom.',
                                                       choices: [meat_choice])

puts "Created #{main_fares_category.default_sub_category.items.count} items in the '#{main_fares_category.default_sub_category.title}' sub-category of the '#{main_fares_category.title}' category."

# Create room service items for grills.
from_the_grill_category = RoomService::Category.find_by(title: 'From the Grill')
from_the_grill_category.default_sub_category.items.create!(title: 'Tiger Prawns', price: 10.000, tags: [seafood_tag, dairy_tag],
                                                           description: 'On olive risotto, green asparagus in saffron broth.')
from_the_grill_category.default_sub_category.items.create!(title: 'Catch of the Day', price: 5.200, tags: [seafood_tag, dairy_tag],
                                                           description: 'With mashed potato, sautéed spinach accompanied by a lemon-herb butter sauce.')
from_the_grill_category.default_sub_category.items.create!(title: 'Angus Beef Rib Eye (200gm)', price: 16.500, tags: [spicy_tag, dairy_tag],
                                                           description: 'Baked potato, sour cream, mushrooms, green vegetables with green peppercorn sauce.')
from_the_grill_category.default_sub_category.items.create!(title: 'Lamb Chops', price: 8.500, tags: [dairy_tag],
                                                           description: 'With rosemary potatoes and sautéed garlic spinach, served with natural gravy.')
from_the_grill_category.default_sub_category.items.create!(title: 'Arabian Mixed Grill', price: 7.000, tags: [nuts_and_seeds_tag],
                                                           description: 'Lamb chops, sheesh tawook, beef medallions, kofta and beef sausage, served with biryani rice.')
from_the_grill_category.default_sub_category.items.create!(title: 'Sheesh Tawook', price: 4.800, tags: [dairy_tag, spicy_tag],
                                                           description: 'Tender pieces of chicken, marinated with yoghurt and oriental spices on a bed of rice.')
from_the_grill_category.default_sub_category.items.create!(title: 'Darne of Salmon', price: 7.500, tags: [seafood_tag, dairy_tag],
                                                           description: 'Grilled and served with lemon butter, market vegetables and parsley potatoes.')

puts "Created #{from_the_grill_category.default_sub_category.items.count} items in the '#{from_the_grill_category.default_sub_category.title}' sub-category of the '#{from_the_grill_category.title}' category."

# Create room service item choices for pasta.
pasta_choice = RoomService::ItemChoice.create!(title: 'Pasta', optional: false, allows_multiple_options: false)
pasta_choice.options.create!([
                               { title: 'Spaghetti', price: 0 },
                               { title: 'Penne', price: 0 },
                               { title: 'Tagliatelle', price: 0 },
                               { title: 'Fusilli', price: 0 }
                             ])

# Create room service items for pasta.
pasta_category = RoomService::Category.find_by(title: 'Pasta')
pasta_category.default_sub_category.items.create!(title: 'Seafood', price: 5.500, tags: [seafood_tag, egg_tag, dairy_tag],
                                                  description: 'Tiger prawns, calamari, cockles and vegetable julienne, with white tomato-butter sauce.',
                                                  choices: [pasta_choice])
pasta_category.default_sub_category.items.create!(title: 'Al Arrabiata', price: 3.500, tags: [spicy_tag, vegetarian_tag, egg_tag],
                                                  description: 'Spicy tomato sauce with fresh basil.',
                                                  choices: [pasta_choice])
pasta_category.default_sub_category.items.create!(title: 'Carbonara', price: 4.500, tags: [dairy_tag, egg_tag],
                                                  description: 'Beef bacon, fresh cream, egg yolk and parmesan cheese.',
                                                  choices: [pasta_choice])
pasta_category.default_sub_category.items.create!(title: 'Bolognese', price: 4.000, tags: [dairy_tag, vegetarian_tag],
                                                  description: 'Ground meat cooked with tomato sauce, garlic onions and Italian herbs topped with parmesan cheese.',
                                                  choices: [pasta_choice])
pasta_category.default_sub_category.items.create!(title: 'Al Pomodoro', price: 3.500, tags: [vegetarian_tag, egg_tag],
                                                  description: 'Rich and fresh tomato sauce with fresh basil.',
                                                  choices: [pasta_choice])

puts "Created #{pasta_category.default_sub_category.items.count} items in the '#{pasta_category.default_sub_category.title}' sub-category of the '#{pasta_category.title}' category."

# Create room service items for pizza.
pizza_corner_category = RoomService::Category.find_by(title: 'Pizza Corner')
pizza_corner_category.default_sub_category.items.create!(title: 'Margherita', price: 2.200, tags: [dairy_tag, egg_tag, vegetarian_tag],
                                                         description: 'With tomatoes, oregano and basil.',
                                                         choices: [pasta_choice])
pizza_corner_category.default_sub_category.items.create!(title: 'Marinara', price: 4.200, tags: [seafood_tag, egg_tag],
                                                         description: 'Mixed seafood with bell peppers, olives and mushrooms.',
                                                         choices: [pasta_choice])
pizza_corner_category.default_sub_category.items.create!(title: 'Roman', price: 4.200, tags: [dairy_tag, cereals_tag, egg_tag, nuts_and_seeds_tag],
                                                         description: 'With turkey ham, beef salami and chicken mortadella.',
                                                         choices: [pasta_choice])
pizza_corner_category.default_sub_category.items.create!(title: 'Nawabi', price: 3.200, tags: [spicy_tag, dairy_tag, egg_tag],
                                                         description: 'Marinated Indian tandoori chicken, fennel seeds and spiced mint.',
                                                         choices: [pasta_choice])

puts "Created #{pizza_corner_category.default_sub_category.items.count} items in the '#{pizza_corner_category.default_sub_category.title}' sub-category of the '#{pizza_corner_category.title}' category."

# Create room service item choices for burgers and wraps.
side_choice = RoomService::ItemChoice.create!(title: 'Side', optional: false, allows_multiple_options: false)
side_choice.options.create!([
                              { title: 'Fries', price: 0 },
                              { title: 'Salad', price: 0 }
                            ])

# Create room service items for burgers and wraps.
burgers_and_wraps_category = RoomService::Category.find_by(title: 'Burgers & Wraps')
burgers_and_wraps_category.default_sub_category.items.create!(title: 'The K Beef Burger', price: 6.000, tags: [dairy_tag, egg_tag],
                                                              description: 'Topped with sautéed mushrooms, smothered onions, fresh avocados, cheese and fried egg.',
                                                              choices: [side_choice])
burgers_and_wraps_category.default_sub_category.items.create!(title: 'Vegetarian Burger', price: 4.000, tags: [vegetarian_tag, egg_tag],
                                                              description: 'Made of fresh vegetables served with crisp lettuce, tomatoes, pickle relish and caramelized onions.',
                                                              choices: [side_choice])
burgers_and_wraps_category.default_sub_category.items.create!(title: 'Famous Club', price: 3.700, tags: [egg_tag],
                                                              description: 'Juicy thinly sliced chicken, served with tomatoes, cucumbers, lettuce, fried egg, beef bacon and cheese.',
                                                              choices: [side_choice])
burgers_and_wraps_category.default_sub_category.items.create!(title: 'Chicken and Caesar Wrap', price: 3.500, tags: [dairy_tag, egg_tag],
                                                              description: 'Crisp hearts of romaine, grilled chicken breast and parmesan cheese, tossed in creamy caesar dressing, wrapped in a soft flour tortilla.',
                                                              choices: [side_choice])

puts "Created #{burgers_and_wraps_category.default_sub_category.items.count} items in the '#{burgers_and_wraps_category.default_sub_category.title}' sub-category of the '#{burgers_and_wraps_category.title}' category."

# Create room service item choices for kids choice.
kids_choice_meat_choice = RoomService::ItemChoice.create!(title: 'Meat', optional: false, allows_multiple_options: false)
kids_choice_meat_choice.options.create!([
                                          { title: 'Beef', price: 0 },
                                          { title: 'Chicken', price: 0 }
                                        ])

# Create room service items for kids choice.
kids_choice_category = RoomService::Category.find_by(title: 'Kids Choice')
kids_choice_category.default_sub_category.items.create!(title: 'Breaded Fish Fingers', price: 2.500, tags: [egg_tag],
                                                        description: 'Deep-fried fish fingers with fries and tartar sauce.')
kids_choice_category.default_sub_category.items.create!(title: 'Macaroni Cream Sauce', price: 1.800, tags: [vegetarian_tag, dairy_tag, egg_tag],
                                                        description: 'Sautéed with peas, carrots and fresh cream with crispy bread stick.')
kids_choice_category.default_sub_category.items.create!(title: 'Chicken Nuggets', price: 2.000, tags: [egg_tag],
                                                        description: 'Served with cocktail sauce and fries.')
kids_choice_category.default_sub_category.items.create!(title: 'Mini Burger', price: 2.600, tags: [dairy_tag],
                                                        description: 'Choice of beef or chicken, grilled to perfection with cheese topping, served with fries.',
                                                        choices: [kids_choice_meat_choice])
kids_choice_category.default_sub_category.items.create!(title: 'Chocolate Sundae', price: 2.600, tags: [cereals_tag, dairy_tag, egg_tag, nuts_and_seeds_tag],
                                                        description: 'Chocolate ice cream, shortbread biscuits, chocolate fudge cake, fresh strawberries and chocolate sauce.')
kids_choice_category.default_sub_category.items.create!(title: 'Chunky', price: 2.600, tags: [vegetarian_tag],
                                                        description: 'Freshly cut fruits flavored with mint.')

puts "Created #{kids_choice_category.default_sub_category.items.count} items in the '#{kids_choice_category.default_sub_category.title}' sub-category of the '#{kids_choice_category.title}' category."

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
pastries_category.default_sub_category.items.create!(title: 'Assorted Cheese Platter', price: 4.800, tags: [dairy_tag, nuts_and_seeds_tag],
                                                     description: 'Served with pepper spiced pear marmalade, grapes, nuts and crackers.')

puts "Created #{pastries_category.default_sub_category.items.count} items in the '#{pastries_category.default_sub_category.title}' sub-category of the '#{pastries_category.title}' category."

# Create room service item choices for round o'clock menu.
sauce_choice = RoomService::ItemChoice.create!(title: 'Sauce', optional: false, allows_multiple_options: false)
sauce_choice.options.create!([
                               { title: 'Napolitana', price: 0 },
                               { title: 'Bolognese', price: 0 }
                             ])

# Create room service items for round o'clock menu.
round_o_clock_menu_category = RoomService::Category.find_by(title: "Round O'Clock Menu")
round_o_clock_menu_category.default_sub_category.items.create!(title: 'Greek Salad', price: 3.000, tags: [dairy_tag, vegetarian_tag, healthy_tag, mustard_and_celery_tag],
                                                               description: 'Lettuce, bell peppers, cucumbers, tomatoes, feta cheese, red onions, olives, tossed in a light herb vinaigrette.')
round_o_clock_menu_category.default_sub_category.items.create!(title: 'Oriental Mezzah - Hot and Cold', price: 6.500, tags: [vegetarian_tag, healthy_tag, nuts_and_seeds_tag],
                                                               description: 'Hummus, moutabel, tabouleh, stuffed vine leaves meat kibbeh, cheese sambousek and spinach fatayer.')
round_o_clock_menu_category.default_sub_category.items.create!(title: 'Cream of Mushroom Soup ', price: 2.000, tags: [dairy_tag, vegetarian_tag, healthy_tag],
                                                               description: 'Blended white and shiitake mushrooms, topped with cream cheese and micro herbs.')
round_o_clock_menu_category.default_sub_category.items.create!(title: 'The K Chicken Burger', price: 5.500, tags: [dairy_tag, cereals_tag, egg_tag, nuts_and_seeds_tag, mustard_and_celery_tag],
                                                               description: 'Seasoned chicken minced patty cooked to perfection, served with a slice of pineapple, lettuce, tomato, cheese and chunky chips.')
round_o_clock_menu_category.default_sub_category.items.create!(title: 'Cream of Mushroom Soup', price: 2.000, tags: [dairy_tag, vegetarian_tag, healthy_tag],
                                                               description: 'Blended white and shiitake mushrooms, topped with cream cheese and micro herbs.')
round_o_clock_menu_category.default_sub_category.items.create!(title: 'The K Beef Burger', price: 6.000, tags: [dairy_tag, egg_tag],
                                                               description: 'Topped with sautéed mushrooms, smothered onions, fresh avocados, cheese, fried egg and French fries.')
round_o_clock_menu_category.default_sub_category.items.create!(title: 'Famous Club', price: 3.700, tags: [dairy_tag, spicy_tag, egg_tag],
                                                               description: 'Juicy thinly sliced chicken, served with tomatoes, cucumbers, lettuce, fried egg, beef bacon, cheese and French fries.')
round_o_clock_menu_category.default_sub_category.items.create!(title: 'Spaghetti Napolitana or Bolognese', price: 4.000, tags: [dairy_tag, nuts_and_seeds_tag],
                                                               description: 'Pasta with either tomato or chunky meat sauce, sprinkled with parmesan cheese and basil pesto, black cracked pepper.',
                                                               choices: [sauce_choice])
round_o_clock_menu_category.default_sub_category.items.create!(title: 'Traditional Biryani (Raita and Garnish)', price: 4.200, tags: [dairy_tag, nuts_and_seeds_tag, egg_tag],
                                                               description: 'Traditional Indian style biryani rice with chicken or lamb meat served with cucumber-yoghurt raita and poppadom.',
                                                               choices: [meat_choice])
round_o_clock_menu_category.default_sub_category.items.create!(title: 'Assorted Fresh Fruits', price: 2.500, tags: [healthy_tag],
                                                               description: 'Our daily selection of fruit cuts infused with orange and mint syrup.')
round_o_clock_menu_category.default_sub_category.items.create!(title: '“New York” Cheesecake', price: 3.000, tags: [dairy_tag, egg_tag, nuts_and_seeds_tag],
                                                               description: 'Topped with blueberries.')

puts "Created #{round_o_clock_menu_category.default_sub_category.items.count} items in the '#{round_o_clock_menu_category.default_sub_category.title}' sub-category of the '#{round_o_clock_menu_category.title}' category."

# Create room service items for beverages.
beverages_category = RoomService::Category.find_by(title: 'Beverages Hot & Cold')
hot_beverages_sub_category = RoomService::SubCategory.create!(category: beverages_category, title: 'Hot Beverages')
cold_beverages_sub_category = RoomService::SubCategory.create!(category: beverages_category, title: 'Cold Beverages')
energy_drinks_sub_category = RoomService::SubCategory.create!(category: beverages_category, title: 'Energy Drinks')
beer_and_wine_sub_category = RoomService::SubCategory.create!(category: beverages_category, title: 'Beer & Wine')
hot_beverages_sub_category.items.create!(title: 'Tea Selection', price: 1.800)
hot_beverages_sub_category.items.create!(title: 'American Coffee', price: 1.800)
hot_beverages_sub_category.items.create!(title: 'Espresso', price: 2.200)
hot_beverages_sub_category.items.create!(title: 'Espresso Double', price: 3.100)
hot_beverages_sub_category.items.create!(title: 'Cappuccino', price: 3.100)
hot_beverages_sub_category.items.create!(title: 'Caffè Latte', price: 3.100)
hot_beverages_sub_category.items.create!(title: 'Turkish Coffee', price: 2.200)
hot_beverages_sub_category.items.create!(title: 'Hot Milk', price: 2.200)
cold_beverages_sub_category.items.create!(title: 'Evian 1.5l', price: 4.400)
cold_beverages_sub_category.items.create!(title: 'Evian 500ml', price: 2.900)
cold_beverages_sub_category.items.create!(title: 'Highland Water 1l', price: 2.800)
cold_beverages_sub_category.items.create!(title: 'Highland Water 500ml', price: 1.700)
cold_beverages_sub_category.items.create!(title: 'Perrier 330ml', price: 3.000)
cold_beverages_sub_category.items.create!(title: 'Perrier 750ml', price: 4.500)
cold_beverages_sub_category.items.create!(title: 'Soda, Ginger Ale, Tonic 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Coca Cola 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Coca Cola Zero 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Coca Cola Diet 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Sprite 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Sprite Diet 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Fanta 330ml', price: 1.800)
cold_beverages_sub_category.items.create!(title: 'Fresh Orange Juice 300ml', price: 2.500)
cold_beverages_sub_category.items.create!(title: 'Lemon and Mint 300ml', price: 2.500)
cold_beverages_sub_category.items.create!(title: 'Carrot Juice 300ml', price: 2.500)
cold_beverages_sub_category.items.create!(title: 'Milkshake', price: 2.200)
cold_beverages_sub_category.items.create!(title: 'Ice Tea', price: 2.200)
cold_beverages_sub_category.items.create!(title: 'Cold Milk', price: 2.200)
energy_drinks_sub_category.items.create!(title: 'Effect 250ml', price: 2.900)
beer_and_wine_sub_category.items.create!(title: 'Coors Light (Bottle) 330ml', price: 3.900)
beer_and_wine_sub_category.items.create!(title: 'Kronenbourg 1664 (Bottle) 330ml', price: 4.100)
beer_and_wine_sub_category.items.create!(title: 'House Wine (Glass)', price: 3.200)
beer_and_wine_sub_category.items.create!(title: 'House Wine (Bottle)', price: 15.000)
beer_and_wine_sub_category.items.create!(title: 'Champagne (Bottle)', price: 26.000)
beer_and_wine_sub_category.items.create!(title: 'B52', price: 4.000)
beer_and_wine_sub_category.items.create!(title: 'Brain Hemorrhage', price: 4.000)
beer_and_wine_sub_category.items.create!(title: 'Lemon Drop', price: 4.000)

puts "Created #{beverages_category.default_sub_category.items.count} items in the '#{beverages_category.default_sub_category.title}' sub-category of the '#{beverages_category.title}' category."

# Create room service items for cocktails.
cocktails_category = RoomService::Category.find_by(title: 'Cocktails')
cocktails_category.default_sub_category.items.create!(title: 'Typhoon', price: 4.000, description: 'Malibu, Cointreau, fresh orange juice, fresh cream and grenadine syrup.')
cocktails_category.default_sub_category.items.create!(title: 'Mai Tai', price: 4.000, description: 'Dark rum, light rum, triple sec, orange juice, pineapple juice, grenadine.')
cocktails_category.default_sub_category.items.create!(title: 'Mojito', price: 4.000, description: 'Rum, mint, brown sugar, lime soda.')

puts "Created #{cocktails_category.default_sub_category.items.count} items in the '#{cocktails_category.default_sub_category.title}' sub-category of the '#{cocktails_category.title}' category."

# Create room service items for mocktails.
mocktails_category = RoomService::Category.find_by(title: 'Mocktails')
mocktails_category.default_sub_category.items.create!(title: 'Tutti Frutti', price: 2.500, description: 'Strawberry, banana, orange, lemon.')
mocktails_category.default_sub_category.items.create!(title: 'Piña Colada', price: 2.500, description: 'Pineapple, coconut milk, sweetened with honey.')
mocktails_category.default_sub_category.items.create!(title: 'Sunrise', price: 2.500, description: 'Peaches, melons, oranges and banana blended with milk.')

puts "Created #{mocktails_category.default_sub_category.items.count} items in the '#{mocktails_category.default_sub_category.title}' sub-category of the '#{mocktails_category.title}' category."

puts "Created #{RoomService::ItemChoice.count} room service item choices."
puts "Created #{RoomService::ItemChoiceOption.count} room service item choice options."