namespace :db do
  namespace :development do

    desc "Populate sample data"
    task :populate => [
      'populate_users', 'populate_regions', 'populate_region_sets',
      'populate_region_set_memberships', 'populate_locations', 'populate_studies']

    desc "Populate sample region sets"
    task :populate_studies => :environment do
      [Study].each(&:delete_all);

      # Add columbus to ohio
      s = Study.new()
      s.id = 1
      s.region_set_id = 1
      s.user_id = 505
      s.name = 'Ohio Cities Pretty'
      s.slug = 'oh-metro-pretty'
      s.public = TRUE
      s.question = "prettier"
      s.description = "This study identifies the prettiest parts of Ohio's metro areas."
      s.save()

      # Add columbus to ohio
      s = Study.new()
      s.id = 2
      s.region_set_id = 1
      s.user_id = 505
      s.name = 'Ohio Cities Scary'
      s.slug = 'oh-metro-scary'
      s.public = TRUE
      s.question = "most terrifying"
      s.description = "This study explores whether or not any parts of Ohio's metro areas are scary."
      s.save()

    end

    desc "Populate sample region sets"
    task :populate_region_set_memberships => :environment do
      [RegionSetMembership].each(&:delete_all);

      # Add columbus to ohio
      r = RegionSetMembership.new()
      r.region_set_id = 1
      r.region_id = 43210
      r.save()

      # Add dayton to ohio
      r = RegionSetMembership.new()
      r.region_set_id = 1
      r.region_id = 45419
      r.save()

      # Add cleveland to ohio
      r = RegionSetMembership.new()
      r.region_set_id = 1
      r.region_id = 44130
      r.save()

      # Add toledo to ohio
      r = RegionSetMembership.new()
      r.region_set_id = 1
      r.region_id = 43613
      r.save()

      # Add nyc to us
      r = RegionSetMembership.new()
      r.region_set_id = 2
      r.region_id = 10453
      r.save()

      # Add houston to us
      r = RegionSetMembership.new()
      r.region_set_id = 2
      r.region_id = 77006
      r.save()

      # Add san francisco to us
      r = RegionSetMembership.new()
      r.region_set_id = 2
      r.region_id = 94101
      r.save()


    end


    desc "Populate sample region sets"
    task :populate_region_sets => :environment do
      [RegionSet].each(&:delete_all);

      r = RegionSet.new()
      r.id = 1
      r.slug = 'oh-cities'
      r.name = 'Ohio Cities'
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = RegionSet.new()
      r.id = 2
      r.slug = 'us-major-cities'
      r.name = 'US Major Cities'
      r.public = TRUE
      r.user_id = 501
      r.save()

    end

    desc "Populate sample regions"
    task :populate_regions => :environment do
      [Region].each(&:delete_all);

      r = Region.new()
      r.id = 43210
      r.slug = 'oh-columbus'
      r.name = 'Columbus'
      r.latitude = 39.9816886411623
      r.longitude = -83.0172621627688
      r.zoom = 10
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 45419
      r.slug = 'oh-dayton'
      r.name = 'Dayton'
      r.latitude = 39.7589
      r.longitude = -84.1917
      r.zoom = 10
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 44130
      r.slug = 'oh-cleveland'
      r.name = 'Cleveland'
      r.latitude = 41.4994
      r.longitude = -81.6956
      r.zoom = 10
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 43613
      r.slug = 'oh-toledo'
      r.name = 'Toledo'
      r.latitude = 41.6639
      r.longitude = -83.5553
      r.zoom = 10
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 10453
      r.slug = 'ny-newyork'
      r.name = 'New York City'
      r.latitude = 40.7142
      r.longitude = -74.0064
      r.zoom = 10
      r.public = TRUE
      r.user_id = 501
      r.save()

      r = Region.new()
      r.id = 94101
      r.slug = 'ca-sanfrancisco'
      r.name = 'San Francisco'
      r.latitude = 37.7750
      r.longitude = -122.4183
      r.zoom = 10
      r.public = TRUE
      r.user_id = 501
      r.save()

      r = Region.new()
      r.id = 77006
      r.slug = 'tx-houston'
      r.name = 'Houston'
      r.latitude = 29.7631
      r.longitude = -95.3631
      r.zoom = 10
      r.public = TRUE
      r.user_id = 501
      r.save()
    end


    desc "Populate sample locations"
    task :populate_locations => :environment do
      [Location].each(&:delete_all);

      l = Location.new()
      l.id = 1
      l.region_id = 43210
      l.latitude = 39.9816886411623
      l.longitude = -83.0172621627688
      l.heading = 90
      l.pitch = 90
      l.save()

      l = Location.new()
      l.id = 2
      l.region_id = 43210
      l.latitude = 39.9816886411623
      l.longitude = -83.0182621627688
      l.heading = 90
      l.pitch = 90
      l.save()

      l = Location.new()
      l.id = 3
      l.region_id = 43210
      l.latitude = 39.9816886411623
      l.longitude = -83.0192621627688
      l.heading = 90
      l.pitch = 90
      l.save()

      l = Location.new()
      l.id = 4
      l.region_id = 43210
      l.latitude = 39.9816886411623
      l.longitude = -83.0212621627688
      l.heading = 90
      l.pitch = 90
      l.save()

    end

    desc "Populate sample users"
    task :populate_users => :environment do

      [User].each(&:delete_all)

      u = User.new()
      u.id = 500
      u.username = "jake"
      u.name = "Jake Fake"
      u.email = 'jakefake@example.com'
      u.password = "password"
      u.password_confirmation = u.password
      u.reset_password_token = u.id
      u.save()

      u = User.new()
      u.id = 501
      u.username = "test"
      u.name = "Test McFerguson"
      u.email = "testferg@example.com"
      u.password = "password"
      u.password_confirmation = u.password
      u.reset_password_token = u.id
      u.save()

      u = User.new()
      u.id = 502
      u.username = "sam"
      u.name = "Sam Sample"
      u.email = "samsample@example.com"
      u.password = "password"
      u.password_confirmation = u.password
      u.reset_password_token = u.id
      u.save()

      u = User.new()
      u.id = 503
      u.username = "roger"
      u.name = "Roger Regression"
      u.email = "rogerregress@example.com"
      u.password = "password"
      u.password_confirmation = u.password
      u.reset_password_token = u.id
      u.save()

      u = User.new()
      u.id = 504
      u.username = "elbert"
      u.name = "Elbert Exception"
      u.email = "elbertexception@example.com"
      u.password = "password"
      u.password_confirmation = u.password
      u.reset_password_token = u.id
      u.save()

      u = User.new()
      u.id = 505
      u.username = "dana"
      u.name = "Dana Datum"
      u.email = "danadatum@example.com"
      u.password = "password"
      u.password_confirmation = u.password
      u.reset_password_token = u.id
      u.save()

      u = User.new()
      u.id = 506
      u.username = "sara"
      u.name = "Sara Soap"
      u.email = "sarasoap@example.com"
      u.password = "password"
      u.password_confirmation = u.password
      u.reset_password_token = u.id
      u.save()

      u = User.new()
      u.id = 507
      u.username = "rachel"
      u.name = "Rachel Rest"
      u.email = "rachelrest@example.com"
      u.password = "password"
      u.password_confirmation = u.password
      u.reset_password_token = u.id
      u.save()

      u = User.new()
      u.id = 508
      u.username = "alice"
      u.name = "Alice Abstract"
      u.email = "aliceabstract@example.com"
      u.password = "donttelleve"
      u.password_confirmation = u.password
      u.reset_password_token = u.id
      u.save!()

    end
  end
end
