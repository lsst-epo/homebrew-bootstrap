## Development Environment

This project uses docker and docker-compose to setup a development environment. You'll need to install a current version of docker, which you can get here: https://docs.docker.com/docker-for-mac/install/

To setup this project for the first time, begin by eyeballing the Dockerfile in this repo. Does it contain the correct PHP version on the base image? Look at the docker-compose.yml file. Is the node image you're using correct?

Then, follow these steps:

```

# Setup your .env file
cp .env.sample .env

# Set OCTOBER_DB_PASSWORD to a random value.
# Ensure OCTOBER_DB_HOST is set to "database"
# Set OCTOBER_DB_USERNAME to not root, or don't.
$EDITOR .env

# Start up the containers. This will take longer the first time because
# Docker will need to build the October container.
docker-compose up

# While Docker is running, open a new terminal window to setup october.

# Install PHP dependencies
docker-compose exec october composer install

# Run database migrations
docker-compose exec october php artisan october:up

# Make an admin user with username "admin" and password "admin"
docker exec database /var/lib/queries/run_sql.sh create_admin.sql
```

Now, visit the site at http://localhost:8000 and hurray, it worked!

#### Other useful commands:

```
# Connect to mysql. The database container exposes MySQL on port 8001.
mysql --host=127.0.0.1 --port=8001 --user=$DB_USER --password $DB_NAME

# Reset a user's password
docker-compose exec october php artisan october:passwd admin password

# Run an Artisan command
docker-compose exec october php artisan some-command

# Add a node module
docker-compose exec node yarn add some-module

# Update a node module
docker-compose exec node yarn upgrade node-sass

# Force rebuild a the October image after changing the Dockerfile
docker-compose up --build --force-recreate --no-deps october
```

#### Connecting to the database

With October, we store our database connection information in the .env file in the project root. When the database container starts up, docker will source the .env file. Our docker-compose configuration will pass the October database env vars to the MySQL container. When that container first starts, it will create a database and user based on the variables. All mysql data is stored in docker-compose/mysql/data in your project. If you want to recreate your database, you can remove that directory and recreate your containers.

#### Using Warewolf

To use warewolf, you need to configure it to connect to the datbase running in the local container. For this to work, you will need Warewolf v1.5 or later, as previous versions didn't allow users to configure the mysql port. Your config will look more or less like this:

```
db_name=$OCTOBER_DB_NAME
db_user=$OCTOBER_DB_USER
db_pass=$OCTOBER_DB_PASSWORD
db_host=127.00.1
db_port=8001
```

The variables above can all be found in the .env file. Be sure to use the 127.0.0.1 IP address for the host. I've seen cases where localhost doesn't resolve properly in this context, not sure why yet.
