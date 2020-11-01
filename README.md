# MedicalPersistanceSystem
http://medicalpersistencesystem2020.herokuapp.com/

# how to install
```sh
git clone https://github.com/Siyangyang/MedicalPersistanceSystem2020.git
rvm install 2.4.0
rvm use 2.4.0
```

## deployee to heroku
```sh
sudo snap install heroku --classic
heroku login --interactive
heroku keys:add
heroku apps:create
git push heroku master
```
### here, if running on other branch then master, run following line instead
```sh
git push heroku [branch name]:master
#as we currently on mingreng's branch, we will be using
git push heroku [branch name]:master
heroku run rake db:setup
heroku run rake db:migrate
heroku run rake db:seed
```

##################################split line##################################

## How to deploy on local:
This is way more tedious due to postgres

For more information see
http://zetcode.com/db/postgresqlruby/

For now, a short guild to set up postgresql on local
```sh
Installation and set up:
sudo apt-get install postgresql
sudo apt-get install libpq-dev
```
### to set up a password
```sh
sudo -u postgres psql postgres
psql (9.3.9)
Type "help" for help.

postgres=# \password postgres
#after setting up the password, use following to quit
postgres=# \q
```
### now we can install bundle without error by run
```sh
bundle install
```
### proceed to deploy this to local, first we need to initialize the db
```sh
sudo service postgresql start
sudo service postgresql status
```
### we use sudo -u postgres createuser [user name]
```sh
sudo -u postgres createuser ubuntu
$ sudo -u postgres psql postgres
psql (9.3.9)
Type "help" for help.

#postgres=# ALTER USER [user name] WITH password '[password]';
postgres=# ALTER USER ubuntu WITH password '[password]';
ALTER ROLE
postgres=# ALTER USER ubuntu CREATEDB;
postgres=# \q
```
### Now  we create this db in advance. It suppose to be done by rake db:migrate/ect but due to some privilege issue we have to run following commend
```sh
#sudo -u postgres createdb [db name] --owner [user name]
#to be precise, we will run
sudo -u postgres createdb myapp_development --owner [user name]
sudo -u postgres createdb myapp_test --owner [user name]
#because name of db used by app is myapp_development and myapp_test 

rake db:setup
rake db:migrate
rake db:seed
rails server -b $IP -p $PORT
```

## remember to run following command after switching branch
```sh
rake db:setup
rake db:migrate
rake db:seed
```
