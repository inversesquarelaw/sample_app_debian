require 'faker'

namespace :db do

  desc "Filling database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "Example user", 
                 :email => "example@railstutorial.org",
                 :password => "barfoo",
                 :password_confirmation => "barfoo"
                )
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "barfoo"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password
                  )
    end #99
  end #task
end #namespace
