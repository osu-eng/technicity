namespace :db do
  namespace :development do

    desc "Populate Development Database with Fake Data"
    task :populate_fake_data => :environment do
      [Comparison, Location, Region, Study, User].each(&:delete_all)

      puts "Creating Users"

      u = User.new()
      u.id = 500
      u.name = "Jake Fake"
      u.email = 'jakefake@example.com'
      u.save()

      u = User.new()
      u.id = 501
      u.name = "Test McFerguson"
      u.email = "testferg@example.com"
      u.save()

      u = User.new()
      u.id = 502
      u.name = "Sam Sample"
      u.email = "samsample@example.com"
      u.save()

      u = User.new()
      u.id = 503
      u.name = "Roger Regression"
      u.email = "rogerregress@example.com"
      u.save()

      u = User.new()
      u.id = 504
      u.name = "Elbert Exception"
      u.email = "elbertexception@example.com"
      u.save()

      u = User.new()
      u.id = 505
      u.name = "Dana Datum"
      u.email = "danadatum@example.com"
      u.save()

      u = User.new()
      u.id = 506
      u.name = "Sara Soap"
      u.email = "sarasoap@example.com"
      u.save()

      u = User.new()
      u.id = 507
      u.name = "Rachel Rest"
      u.email = "rachelrest@example.com"
      u.save();

      u = User.new()
      u.id = 508
      u.name = "Alice Abstract"
      u.email = "aliceabstract@example.com"
      u.save()

    end
  end
end
