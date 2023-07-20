# ecommerce
Dockerized ecommerce  

### Installation  
**Download the ecommerce repo** [https://github.com/Bucked-Up/ecommerce](https://github.com/Bucked-Up/ecommerce)  
**Rename .env_copy to .env**  
Add your credentials to the appropriate variables.
```.env
# exapmple
MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_USER=your_mysql_username
MYSQL_PASSWORD=your_mysql_password
```  
**Add 00-init.php file to ./ecommerce/dist/config/ use the credentials added in the .env file**  
**Add dev_ecommerce.sql file to ./install/**  
**Download the lastest version of Docker Desktop**
[https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)  
Select the platform to install it on. Follow the install instructions.

**Check if docker and docker-compose are installed.**  
```bash
docker --version
```
```bash
docker-compose --version
```

**cd into /ecommerce/dist/**
Install composer dependencies 
```bash
composer install 
```
**cd back to the root directory the directory with the file _docker-compose.yml_ file in it.**  
```bash
docker-compose up -d
```
Allow the database to finish populating.
You should be all set up now. Use the URL http://localhost:8080

## Commands to know:
```
# Starts existing containers for a service.
docker-compose start

# Stops running containers without removing them.
docker-compose stop

# Pauses running containers of a service.
docker-compose pause

# Unpauses paused containers of a service.
docker-compose unpause

# Lists containers.
docker-compose ps

# Builds, (re)creates, starts, and attaches to containers for a service. Adding -d or --detach will run docker in the background
docker-compose up

# Stops containers and removes containers, networks, volumes, and images created by up.
docker-compose down

# To see all running containers
docker ps

# To get inside a running container
docker exec -it CONTAINERNAME/CONTAINERID bash
```