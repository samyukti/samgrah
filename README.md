## About

Samgrah is a simple Library Management System built using Ruby on Rails.

At this moment, the primary purpose is to use this project as a training ground in Samyukti.
In future we may consider to develop this as a full-fledged application.

## Installation

Install Ruby on Rails. Probably http://guides.railsgirls.com/install is an easy way to do it.

Install PostgreSQL. Refer https://wiki.postgresql.org/wiki/Detailed_installation_guides.

Clone this repository into your computer

    cd ~
    mkdir -p Code
    cd Code
    git clone https://github.com/samyukti/samgrah.git Samgrah

Configure the PostgreSQL database

    create user samgrah with encrypted password 'samgrah';
    alter user samgrah createdb;
    create database samgrah;
    create database samgrah_dev;
    create database samgrah_test;
    alter database samgrah owner to samgrah;
    alter database samgrah_dev owner to samgrah;
    alter database samgrah_test owner to samgrah;

Install the dependencies

    cd Samgrah
    bundle install

Configure the application

    cd config
    mv database.example.yml database.yml
    mv secrets.example.yml secrets.yml
    rake secret

Update secrets.yml with the string generated from "rake secret".

Reset the database

    rake db:reset

Load default settings

    rake db:settings

Populate demo data

    rake db:history

Start the application in development mode

    rails server
