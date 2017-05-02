# John user
john = User.create!(email: "joedoe@example.com",
                    password: "foobar1",
                    password_confirmation: "foobar1")
              
# John profile
john.create_profile!(first_name: "John", 
                    last_name: "Doe",
                    gender: "male",
                    religion: "other",
                    occupation: "Salesman",
                    date_of_birth: Date.new(1990,1,1),
                    city: "Fitzroy",
                    post_code: "3065",
                    country: "Australia",
                    looking_for: "dating",
                    preferred_gender: "female",
                    min_age: 22,
                    max_age: 32,
                    nearby: true,
                    smoke: "not at all",
                    drink: "socially",
                    edu_status: "completed",
                    edu_type: "high school",
                    hobbies: "Hiking, fishing, photography",
                    movies: "The Avengers, The Dark Knight, Lord of the Rings",
                    tv_shows: "Firefly, Battlestar Galactica, The Expanse",
                    books: "The Hobbit, 1984, Dune, Ender's Game")
                    
# Naomi - Matches with John
naomi = User.create!(email: "naomi@example.com",
                    password: "foobar1",
                    password_confirmation: "foobar1")
                    
# Naomi profile
naomi.create_profile!(first_name: "Naomi", 
                    last_name: "Smith",
                    gender: "female",
                    religion: "atheist",
                    occupation: "student",
                    date_of_birth: Date.new(1992,1,1),
                    city: "Melbourne",
                    post_code: "3000",
                    country: "Australia",
                    looking_for: "dating",
                    preferred_gender: "male",
                    min_age: 22,
                    max_age: 32,
                    nearby: true,
                    smoke: "not at all",
                    drink: "socially",
                    edu_status: "working on",
                    edu_type: "university",
                    hobbies: "Hiking, photography",
                    movies: "Whiplash, Pulp Ficiton, The Avengers",
                    tv_shows: "Firefly, Battlestar Galactica, The Expanse",
                    books: "The Hobbit, 1984, Dune, Ender's Game")

# Jess - lower match than Naomi
jess = User.create!(email: "jess@example.com",
                    password: "foobar1",
                    password_confirmation: "foobar1")
                    
# Jess profile
jess.create_profile!(first_name: "Jess", 
                    last_name: "Fantella",
                    gender: "female",
                    religion: "buddhist",
                    occupation: "accountant",
                    date_of_birth: Date.new(1989,1,1),
                    city: "Melbourne",
                    post_code: "3000",
                    country: "Australia",
                    looking_for: "dating",
                    preferred_gender: "male",
                    min_age: 22,
                    max_age: 32,
                    nearby: true,
                    smoke: "often",
                    drink: "not at all",
                    edu_status: "dropped out of",
                    edu_type: "post grad",
                    hobbies: "LARPing, Board games, Baton twirling",
                    movies: "Fight Club, One Flew Over the Cuckoo's Nest, Casablanca, Interstellar",
                    tv_shows: "Planet Earth II, The Wire, Sherlock, One Punch Man",
                    books: "Catcher in the Rye, Them, No Logo, The Little Prince, Hyperspace")
              
# Admin user
User.create!(email: "admin@example.com",
            admin: true,
            password: "foobar1",
            password_confirmation: "foobar1")
            
            
# ------ Randomly generated user
# email = "random@example.com"
# password = "foobar1"

# # random = User.create!(
# #   email: email,
# #   password: password,
# #   password_confirmation: password)

# gender = Choices['gender'].sample
# # determine first name based on gender

# # male-names.json and female-names.json downloaded from: https://github.com/AlessandroMinoccheri/human-names

# # Profile for randomly generated
# gender = Choices['gender'].sample
# last_name = Faker::Name.last_name
# occupation = Faker::Company.profession
# religion = Choices['religion'].sample
# date_of_birth = Faker::Date.between(Date.new(1960, 1, 1), Date.new(1999, 1, 1))
# smoke = Choices['smoke'].sample
# drink = Choices['drink'].sample
# self_summary = Faker::Hipster.paragraph
# preferred_gender = Choices['preferred_gender'].sample

# ## Determine age range based on user age
# now = Time.now.utc.to_date
# age = now.year - date_of_birth.year - ((now.month > date_of_birth.month || (now.month == date_of_birth.month && now.day >= date_of_birth.day)) ? 0 : 1)

# if age > 22
#   min_age = age-5
# else
#   min_age = age
# end

# max_age = age+5

# ## Get location
# latitude = Faker::Address.latitude
# longitude = Faker::Address.longitude

# random.create_profile!()

# User.create!(first_name: first_name,
#             last_name: last_name,
#             gender: gender,
#             email: email,
#             date_of_birth: date_of_birth,
#             occupation: occupation,
#             religion: religion,
#             lat: lat,
#             long: long,
#             self_summary: self_summary,
#             looking_for: looking_for,
#             preferred_gender: preferred_gender,
#             min_age: min_age,
#             max_age: max_age,
#             password: password,
#             password_confirmation: password)
            
# ### Ignore for now:

# 500.times do |n|
  
#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name
#   gender = genders.sample
#   date_of_birth = Faker::Date.between(Date.new(1949, 1, 1), Date.new(1999, 1, 1))
#   religion = religions.sample
#   occupation = Faker::Company.profession
#   self_summary = Faker::Hipster.paragraph
  
#   preferred_gender = preferred_genders.sample
#   looking_for = looking_fors.sample
  
#   age = Date.today.year - date_of_birth.year
#   min_age = Faker::Number.between(age, age+1)
#   max_age = Faker::Number.between(min_age, 100)
  
#   lat = Faker::Address.latitude
#   long = Faker::Address.longitude
  
#   email = Faker::Internet.email
#   password = "foobar1"
  
#   User.create!(first_name: first_name,
#               last_name: last_name,
#               gender: gender,
#               email: email,
#               date_of_birth: date_of_birth,
#               occupation: occupation,
#               religion: religion,
#               lat: lat,
#               long: long,
#               self_summary: self_summary,
#               looking_for: looking_for,
#               preferred_gender: preferred_gender,
#               min_age: min_age,
#               max_age: max_age,
#               password: password,
#               password_confirmation: password)
  
# end
