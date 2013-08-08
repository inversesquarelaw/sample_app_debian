require 'faker'

namespace :db do

  desc "Filling database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    adminuser = User.create!(:name => "Example user", 
                         :email => "example@railstutorial.org", 
                         :password => "barfoo", 
                         :password_confirmation => "barfoo")
    adminuser.toggle!(:admin)
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

    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end #end User.all
  end #task
end #namespace
