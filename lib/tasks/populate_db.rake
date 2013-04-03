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

      # Add columbus to ohio
      s = Study.new()
      s.id = 3
      s.region_set_id = 2
      s.user_id = 505
      s.name = 'Funnest US Cities'
      s.slug = 'us-metro-fun'
      s.public = TRUE
      s.question = "most fun"
      s.description = "This study seeks to find the US capital of fun."
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
      r.description = 'This set contains the metropolitan areas for all major Ohio cities. This is defined roughly as "in the belt".'
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = RegionSet.new()
      r.id = 2
      r.slug = 'us-major-cities'
      r.name = 'US Major Cities'
      r.description = 'This set contains the metropolitan areas for all major US cities. This is defined rougly as "in the belt".'
      r.public = TRUE
      r.user_id = 505
      r.save()

    end

    desc "Populate sample regions"
    task :populate_regions => :environment do
      [Region].each(&:delete_all);

      r = Region.new()
      r.id = 43201
      r.slug = 'oh-columbus-harrison-west'
      r.name = 'Harrison West'
      r.description = 'Harrison West is a neighborhood just northwest of downtown Columbus.'
      r.latitude = 39.978578538820955
      r.longitude = -83.01295801953528
      r.zoom = 14
      r.polygon = '
        (39.99037190112704, -83.02318096204544), (39.99001022351317, -83.01382541657176),
        (39.97393007480583, -83.01060676585621), (39.97439049978266, -83.01545619975514),
        (39.97682412313229, -83.01841735850758), (39.97764627359865, -83.02026271830982)'
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 43210
      r.slug = 'oh-columbus'
      r.name = 'Columbus'
      r.description = 'Columbus is the capital of Ohio. This region includes all suburbs within the outerbelt.'
      r.latitude = 40.000525998949726
      r.longitude = -83.00682111876084
      r.zoom = 10
      r.polygon = '
        (40.10223549586965, -83.11660767300054), (40.10328591293442, -83.07128906948492),
        (40.10538669840983, -82.99781800014898), (40.08752795413118, -82.9106140206568),
        (40.04443758460859, -82.90649414760992), (40.00552775916049, -82.90649414760992),
        (39.99711190624382, -82.86529541714117), (39.96396440280077, -82.84606933768373),
        (39.93501296038254, -82.85293579276185), (39.9034155951341, -82.90100097830873),
        (39.87338459498892, -82.93121338065248), (39.87601941962116, -83.01086425955873),
        (39.89867473290113, -83.05755615408998), (39.90499580965425, -83.0980682442896),
        (39.929747745342944, -83.12347412807867), (40.00079396953218, -83.11180115444591),
        (40.08805327821119, -83.13446045620367)'
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 45419
      r.slug = 'oh-dayton'
      r.name = 'Dayton'
      r.description = 'This includes Dayton and neighboring suburbs.'
      r.latitude = 39.75681927078203
      r.longitude = -84.09904523286967
      r.zoom = 10
      r.polygon = '
        (39.84861229610178, -84.27932740654796), (39.857046423130654, -84.04861451592296),
        (39.66279941218787, -84.10217286553234), (39.65539876418111, -84.29306031670421)
        '
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 24601
      r.slug = 'oh-cincinnati'
      r.name = 'Cincinnati'
      r.description = 'This set includes everything within the 275 outerbelt. This may be a bit too much for those wishing to study Cincinnati (it includes territory in three states).'
      r.latitude = 39.17256558955239
      r.longitude = -84.53369183931498
      r.zoom = 10
      r.polygon = '
        (39.215940656189275, -84.74212647881365), (39.20636415816774, -84.6899414202199),
        (39.27656147830587, -84.57183839287615), (39.29781952290108, -84.5306396624074),
        (39.273372215091804, -84.37133790459484), (39.2265796778083, -84.29855348076671),
        (39.195722073184804, -84.27108766045421), (39.141422365887834, -84.26971436943859),
        (39.09454187889484, -84.29443360771984), (39.061493717083444, -84.31915284600109),
        (39.05616191881161, -84.39331056084484), (39.0476302041304, -84.46746827568859),
        (39.01776108682992, -84.49630738701671), (39.026296408490445, -84.58419801201671),
        (39.06362632365462, -84.64462281670421), (39.08281688364005, -84.71054078545421),
        (39.086014802921795, -84.76959229912609), (39.09454187889484, -84.81628419365734),
        (39.13609660882302, -84.82727052178234), (39.17869138405648, -84.79843141045421),
        (39.316946245617096, -84.47296143975109)'
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 44130
      r.slug = 'oh-cleveland'
      r.name = 'Cleveland'
      r.description = 'This region includes Cleveland and a variety of suburbs'
      r.latitude = 41.45636020233216
      r.longitude = -81.71157880220561
      r.zoom = 10
      r.polygon = '
        (41.48903478831428, -81.70028687920421), (41.579497863194455, -81.55059815850109),
        (41.53325414281322, -81.45172120537609), (41.44375581277325, -81.49566651787609),
        (41.32423243125432, -81.53411866631359), (41.32423243125432, -81.77993775811046),
        (41.47668911274522, -81.92550660576671)'
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 43613
      r.slug = 'oh-toledo'
      r.name = 'Toledo'
      r.description = 'Includes a number of neighboring towns as well.'
      r.latitude = 41.61466744297963
      r.longitude = -83.51745648775248
      r.zoom = 10
      r.polygon = '
        (41.7180304600481, -83.68057252373546), (41.724180549563606, -83.47869874443859),
        (41.6770148220322, -83.41552735771984), (41.53531012183376, -83.47045899834484),
        (41.593878050033965, -83.68194581475109)'
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 10453
      r.slug = 'ny-newyork'
      r.name = 'New York City'
      r.description = 'Includes manhattan, the bronx, parts of statin island, etc.'
      r.latitude = 40.75999572585681
      r.longitude = -73.9820103207603
      r.zoom = 10
      r.polygon = '
        (40.59935608796518, -74.07623291190248), (40.6827208759455, -74.23553466971504),
        (40.79509814519892, -74.15863037284004), (40.88133311333724, -73.87435913260566),
        (40.703545803451426, -73.73016357596504), (40.60144147645398, -73.96362304862123),
        (40.777421721005936, -73.70086670271121)
        '
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 94101
      r.slug = 'ca-sanfrancisco'
      r.name = 'San Francisco'
      r.description = 'Only includes San Francisco proper.'
      r.latitude = 37.757139075695676
      r.longitude = -122.42782636778428
      r.zoom = 11
      r.polygon = '
        (37.76854362092148, -122.51495372503996), (37.80056114033423, -122.4641418736428),
        (37.801646236899785, -122.39685061387718), (37.75225820732333, -122.38449099473655),
        (37.71804716978354, -122.3762512486428), (37.68110323373892, -122.39067080430686),
        (37.678386041261184, -122.4916076939553)'
      r.public = TRUE
      r.user_id = 505
      r.save()

      r = Region.new()
      r.id = 77006
      r.slug = 'tx-houston'
      r.name = 'Houston'
      r.description = 'It\'s pronounced How-ston not Hugh-ston'
      r.latitude = 29.777782177416416
      r.longitude = -95.35934491548686
      r.zoom = 10
      r.polygon = '
        (29.921613319695602, -95.53482057061046), (29.923993777627715, -95.23818971123546),
        (29.84302629154662, -95.17776490654796), (29.672542219068983, -95.15304566826671),
        (29.604506272365295, -95.20248414482921), (29.60211821164736, -95.44692994561046),
        (29.661802757613785, -95.55679322686046), (29.826348356278118, -95.56228639092296)'
      r.public = TRUE
      r.user_id = 505
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
