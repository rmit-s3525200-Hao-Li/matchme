# encoding: utf-8

# Import json data
# male-names.json and female-names.json downloaded from: https://github.com/AlessandroMinoccheri/human-names
@male_names_file = ActiveSupport::JSON.decode(File.read('db/json/male-names.json'))
@female_names_file = ActiveSupport::JSON.decode(File.read('db/json/female-names.json'))
@hobbies_file = ActiveSupport::JSON.decode(File.read('db/json/hobbies.json'))
@books_file = ActiveSupport::JSON.decode(File.read('db/json/books.json'))
@movies_file = ActiveSupport::JSON.decode(File.read('db/json/movies.json'))
@tv_shows_file = ActiveSupport::JSON.decode(File.read('db/json/tv-shows.json'))
@music_file = ActiveSupport::JSON.decode(File.read('db/json/music.json'))
@sports_file = ActiveSupport::JSON.decode(File.read('db/json/sports.json'))
@games_file = ActiveSupport::JSON.decode(File.read('db/json/games.json'))

# Password used for all users
password = "foobar1"

###### RANDOMLY GENERATED USERS ######

# Create 200 users
200.times do |n|
  email = "random-#{n+1}@example.com"
  User.create!(email: email,
                password: password,
                password_confirmation: password)
end

# Profile generator method
def generate_profiles(arr, city, post_code)
  arr.each do |a|
    # Get name based on gender
    gender = Choices['gender'].sample
    if gender == "male"
      first_name = @male_names_file.sample
    else
      first_name = @female_names_file.sample
    end
    
    ## Determine age range based on user age
    date_of_birth = Faker::Date.between(Date.new(1960, 1, 1), Date.new(1999, 1, 1))
    now = Time.now.utc.to_date
    age = now.year - date_of_birth.year - ((now.month > date_of_birth.month || 
                    (now.month == date_of_birth.month && now.day >= date_of_birth.day)) ? 0 : 1)
    if age > 22
      min_age = age-5
    else
      min_age = age
    end
    max_age = age+10
    
    # Interests
    hobbies = @hobbies_file.sample(rand(1..5)).join(", ")
    movies = @movies_file.sample(rand(1..15)).join(", ")
    tv_shows = @tv_shows_file.sample(rand(1..15)).join(", ")
    music = @music_file.sample(rand(1..15)).join(", ")
    books = @books_file.sample(rand(1..15)).join(", ")
    games = @games_file.sample(rand(1..5)).join(", ")
    sports = @sports_file.sample(rand(1..5)).join(", ")
    
    # Generate remaining profile attributes
    country = "Australia"
    last_name = Faker::Name.last_name
    occupation = Faker::Company.profession
    religion = Choices['religion'].sample
    smoke = Choices['smoke'].sample
    drink = Choices['drink'].sample
    drugs = Choices['drugs'].sample
    diet = Choices['diet'].sample
    looking_for = Choices['looking_for'].sample
    preferred_gender = Choices['preferred_gender'].sample
    nearby = [true, false].sample
    edu_status = Choices['edu_status'].sample
    edu_type = Choices['edu_type'].sample
    self_summary = Faker::Hipster.paragraph
    
    a.create_profile!(
                    first_name: first_name, 
                    last_name: last_name,
                    gender: gender,
                    religion: religion,
                    occupation: occupation,
                    date_of_birth: date_of_birth,
                    city: city,
                    post_code: post_code,
                    country: country,
                    looking_for: looking_for,
                    preferred_gender: preferred_gender,
                    min_age: min_age,
                    max_age: max_age,
                    nearby: nearby,
                    smoke: smoke,
                    drink: drink,
                    drugs: drugs,
                    diet: diet,
                    edu_status: edu_status,
                    edu_type: edu_type,
                    hobbies: hobbies,
                    movies: movies,
                    tv_shows: tv_shows,
                    music: music,
                    books: books,
                    games: games,
                    sports: sports,
                    self_summary: self_summary)
  end
  
end

# Decidely Melbourne users
melbourne_users = User.where(id: 1..100)

# Melbourne users will be matched to Hurtsbridge users if 'nearby' attribute is false
hurstbridge_users = User.where(id: 101..150)

# Melbourne users will not be matched to Sydney users
# even if 'nearby' attribute is false
sydney_users = User.where(id: 151..200)

# Create profiles
generate_profiles(melbourne_users, "Melbourne", "3000")
generate_profiles(hurstbridge_users, "Hurstbridge", "3099")
generate_profiles(sydney_users, "Sydney", "2000")

###### MANUALLY CREATED USERS ######

# John user - Matches to Naomi, lower match with Jess
# Should match with Hurstbridge users
john = User.create!(email: "john@example.com",
                    password: password,
                    password_confirmation: password)
              
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
                    nearby: false,
                    smoke: "not at all",
                    drink: "socially",
                    drugs: "never",
                    diet: "vegetarian",
                    edu_status: "completed",
                    edu_type: "high school",
                    hobbies: "Hiking, fishing, photography",
                    movies: "The Avengers, The Dark Knight, Lord of the Rings",
                    tv_shows: "Firefly, Battlestar Galactica, The Expanse",
                    music: "David Bowie, Gorillaz, Arctic Monkeys",
                    books: "The Hobbit, 1984, Dune, Ender's Game",
                    picture: Rails.root.join("db/images/joe.jpeg").open,
                    self_summary: "In time, we all become that which we most hate. That explains how I became a plate of liver and onions.")

# Naomi - Matches with John
# Should not match with Hurstbridge users
naomi = User.create!(email: "naomi@example.com",
                    password: password,
                    password_confirmation: password)
                    
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
                    drugs: "never",
                    diet: "vegetarian",
                    edu_status: "working on",
                    edu_type: "university",
                    hobbies: "Hiking, photography",
                    movies: "Whiplash, Pulp Ficiton, The Avengers",
                    tv_shows: "Firefly, Battlestar Galactica, The Expanse",
                    music: "David Bowie, Gorillaz, Arctic Monkeys",
                    books: "The Hobbit, 1984, Dune, Ender's Game",
                    picture: Rails.root.join("db/images/naomi.jpeg").open,
                    self_summary: "I used to think I was indecisive, but now I’m not too sure.")

# Jess - lower match for Joe than Naomi
jess = User.create!(email: "jess@example.com",
                    password: password,
                    password_confirmation: password)

# Jess profile
jess.create_profile!(first_name: "Jess", 
                    last_name: "Fantella",
                    gender: "female",
                    religion: "buddhist",
                    occupation: "accountant",
                    date_of_birth: Date.new(1989,1,1),
                    city: "Hurstbridge",
                    post_code: "3099",
                    country: "Australia",
                    looking_for: "dating",
                    preferred_gender: "male",
                    min_age: 22,
                    max_age: 32,
                    nearby: false,
                    smoke: "often",
                    drink: "not at all",
                    drugs: "sometimes",
                    diet: "omnivore",
                    edu_status: "dropped out of",
                    edu_type: "post grad",
                    hobbies: "LARPing, Board games, Baton twirling",
                    movies: "Fight Club, One Flew Over the Cuckoo's Nest, Casablanca, Interstellar",
                    tv_shows: "Planet Earth II, The Wire, Sherlock, One Punch Man",
                    books: "Catcher in the Rye, Them, No Logo, The Little Prince, Hyperspace",
                    picture: Rails.root.join("db/images/jess.jpg").open,
                    self_summary: "With me, boredom is always a thing of the past.")

# Admin user
User.create!(email: "admin@example.com",
            admin: true,
            password: password,
            password_confirmation: password)
