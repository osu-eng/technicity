StreetSeen
==========

[![Build Status](https://travis-ci.org/[bkildow]/[technicity].png)](https://travis-ci.org/[bkildow]/[technicity])

StreetSeen hopes to quantitatively understand different perceptions of streets. 
Most of us experience our cities along its streets. We walk along the 
sidewalks, bicycle or drive along the streets and ultimately explore our cities 
via these transportation networks.

Google Streetview allows people to explore places across the world through 
360-degree street-level images. Google Streetview provides a great opportunity 
to study and understand our cities. StreetSeen is a project from Ohio State 
University which extends Google Streetview in order to allow people across the 
globe to experiment in evaluating cities.

Using the ideas from visual preference surveys constructed into pairwise 
surveys we have created an easy to use tool that let’s anyone construct their 
own survey and begin to understand what people think about places in cities 
across the world.

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

###Known Issues

Problems have been observed with libv8, therubyracer, and mysql. You may need 
to install other bits to get these to work with bundle install.

Contributors
------------

  - Jason Little
  - Meghan Frazer
  - Corey Hinshaw
  - Shaun Rowland

Credits
-------

This project is based on the great work of Open Plans Beautiful Street Project 
and MIT’s Media Lab Place Pulse Project. Both of these open source projects 
provided their code on GitHub and served as a foundation for the design of 
StreetSeen. The Mooculus site, developed by Jim Fowler of The Ohio State 
University, provided key reference for this project.

The vast array of imagery is made available by the exceptional Google Maps team.

StreetSeen was built using code from the following open source projects:
  - Ruby on Rails: http://rubyonrails.org
  - Twitter Bootstrap: http://twitter.github.io/bootstrap/
  - Glyphicons: http://glyphicons.com
  - Capistrano: https://github.com/capistrano/capistrano
  - Google Mpas Extensions: http://code.google.com/p/google-maps-extensions/
  - Google Maps sample code: http://gmaps-samples-v3.googlecode.com
  - Capistrano database.yml task: https://gist.github.com/weppos/2769

Copyright and License
---------------------

Copyright 2013 The Ohio State University

Licensed under the Apache License, Version 2.0 (the "License"); you may not use 
this file except in compliance with the License. You may obtain a copy of the 
License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed 
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
CONDITIONS OF ANY KIND, either express or implied. See the License for the 
specific language governing permissions and limitations under the License.
