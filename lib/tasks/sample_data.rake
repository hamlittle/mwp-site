  namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_athletes
    make_posts
  end
end

def make_athletes
  99.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = "example-#{n+1}@cpmwp.org"
    year = "FIrst"
    phone = "(987) 654-3210"
    password = "foobar"
    Athlete.create!(first_name:             first_name,
                    last_name:              last_name,
                    email:                  email,
                    year_in_school:         year,
                    phone_number:           phone,
                    password:               password,
                    password_confirmation:  password)
  end

  # make admin, president, etc. eventually for development
  Athlete.create!(first_name: 'Hamilton',
                 last_name: 'Little',
                 email: 'hamilton.little@gmail.com',
                 year_in_school: 'Fifth+',
                 phone_number: '(650) 793-3251',
                 password: 'foobar',
                 password_confirmation: 'foobar')
end

def make_posts
  athletes = Athlete.all(limit: 5)
  3.times do
    title = Faker::Lorem.sentence(3)
    content = Faker::Lorem.paragraph(5)
    athletes.each do |athlete|
      athlete.posts.create!(title: title, content: content)
    end
  end
end
