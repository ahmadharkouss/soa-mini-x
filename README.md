# API Documentation

The purpose of this project is to provide a production ready environment for the backend of a web app

All API URLs are on HTTPS with valid certificate!

# Prod

In Order to Interact directly with apis, you need to follow the production server link at [https://x.devgains.com](https://x.devgains.com).

## Private API

- [https://x.devgains.com/private](//https://x.devgains.com/private)
- **Login**: `epita`
- **Password**: `Whynotdeploy?`

- You will be prompted to follow a Swagger doc link  where you can test the APIs. 
- An authorization access token is required, which is available at  : [https://x.devgains.com/private/redirect_uri?info=json](https://x.devgains.com/private/redirect_uri?info=json)

## Public API

- **URL**:
  - [https://x.devgains.com/public](https://x.devgains.com/public)




# Dev: test locally

## Run 

- `docker-compose up --build -d`
- On windows you must use WSL!!
- Maybe you need to remove unused images before with `docker system prune -a`
- Ports: 5435, 6379, 4000, 8080, and 443 must be available and not occupied on your machine!

## Private API

- **URL**: 
  - [https://localhost/private](https://localhost/private)
  - [https://x.devgains.com/private](//https://x.devgains.com/private) (you need to change the hosts file on your machine, if you want to test locally)
- **Login**: `epita`
- **Password**: `Whynotdeploy?`

- You will be prompted to a Swagger doc where you can test the APIs. An authorization access token is required, which is available at Keycloak.
- Authorization access token is not required

## Public API

- **URL**:
  - [http://localhost/public](http://localhost/public)
  - [https://x.devgains.com/public](https://x.devgains.com/public) (you need to change the hosts file on your machine,  if you want to test locally)

- You will be prompted to a Swagger doc where you can test the APIs.
