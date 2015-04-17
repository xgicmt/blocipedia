# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

Wiki.destroy_all
User.destroy_all


5.times  do   
	user = User.new(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		password: Faker::Lorem.characters(10)
		)
	user.skip_confirmation!
	user.save!
end
users = User.all

20.times do 
	Wiki.create!(
 	  title:     Faker::Lorem.sentence,
 	  body:      Faker::Lorem.paragraph,
 	  private:   false,
 	  user:   users.sample
 	   )
end
wikis = Wiki.all

10.times do
	Wiki.create!(
		title:    Faker::Lorem.sentence,
		body:     Faker::Lorem.paragraph,
		private:  true,
		user:  users.sample
		)
end
#create an admin user
admin = User.new(
  name:      'Admin User',
  email:     'admin@example.com',
  password:  'helloworld',
  role:      'admin'
  )

admin.skip_confirmation!
admin.save!
#New Premium member
premium = User.new(
  name:      'premium User',
  email:     'premium@example.com',
  password:  'helloworld',
  role:      'premium'
  )
premium.skip_confirmation!
premium.save!
#New Standard Member
standard = User.new(
  name:      'standard User',
  email:     'standard@example.com',
  password:  'helloworld',
  )
standard.skip_confirmation!
standard.save!

puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
