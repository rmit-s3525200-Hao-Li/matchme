# Non-admin user
john = User.create!(email: "joedoe@example.com",
                    password: "foobar1",
                    password_confirmation: "foobar1")
              
# Non-admin profile
john.create_profile!(first_name: "John", 
                    last_name: "Doe",
                    gender: "male",
                    religion: "Other",
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
                    movies: "The Avengers, The Dark Knight, Lord of the Rings",
                    tv_shows: "Firefly, Battlestar Galactica, The Expanse",
                    books: "The Hobbit, 1984, Dune, Ender's Game")

              
# Admin user
User.create!(email: "admin@example.com",
            admin: true,
            password: "foobar1",
            password_confirmation: "foobar1")

# ### Ignore for now:

# genders = ["male", "female"]
# preferred_genders = genders.push("both")
# looking_fors = ["long-term dating", "short-term dating", "casual sex", "new friends"]
# religions = ["Agnosticism", "Atheism", "Christianity", "Judaism", "Catholicism", "Islam", "Buddhism", "Hinduism", "Sikh", "Other"]

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
