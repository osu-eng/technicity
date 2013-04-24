
Local Development
-----------------

To do local development, first clone the git repository.

git clone git@github.com:osu-eng/technicity.git
cd technicity

Next update/install the bundle

   bundle install

Next copy the sqlite database config to database.yml

   cp config/database.example.yml config/database.yml

Also copy the sample application yml file

   cp config/application.example.yml config/application.yml

Next you probably want to run some scripts to create and seed your database

   rake db:migrate
   rake db:seed

Known Issues

Problems have been observed with libv8, therubyracer, and mysql. You may need to install other bits to get these to work with bundle install.

Credits and Licensing
---------------------

http://code.google.com/p/google-maps-extensions/source/browse/google.maps.Polygon.getBounds.js  
http://gmaps-samples-v3.googlecode.com/svn/trunk/poly/poly_edit.html  
