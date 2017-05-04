RoomService::Category.destroy_all

RoomService::Category.create!([{
  title: "Breakfast",
  description: "Served from 6am to 11am"
                              }, {
  title: "Breakfast A La Carte",
  description: "Served from 6am to 11am"
                              }, {
  title: "Starters and Salads"
                              }, {
  title: "Arabic Mezzeh Selection"
                              }, {
  title: "Home-Made Soups"
                              }, {
  title: "Main Fares"
                              }, {
  title: "From The Grill"
                              }, {
  title: "Pasta"
                              }, {
  title: "Pizza Corner"
                              }, {
  title: "Burgers & Wraps"
                              }, {
  title: "Kids Choice"
                              }, {
  title: "Our Pastry Chef's Delights"
                              }, {
  title: "Round O'Clock Menu - 24/7"
                              }, {
  title: "Beverages Hot & Cold",
  description: "Available 24 hours"
                              }
])