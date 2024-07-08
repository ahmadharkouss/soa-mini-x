# API Documentation

The purpose of this project is to provide a production ready environment for the backend of a web app  of social-plateform, like Twiter.

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


# Project Documentation

## Table of Contents

- [Overview](#overview)
- [Folder Structure](#folder-structure)
- [Configuration Files](#configuration-files)
- [Docker Setup](#docker-setup)
- [Backend Source Code](#backend-source-code)

## Overview

This project is structured to manage a web application with an Apache server, a Node.js backend, and integration with Keycloak for authentication. It includes configuration files, Docker setups, and source code organized for both development and production environments.

## Folder Structure

### apache-config

Contains configuration files for the Apache server and the website.

### backend

Source code in Node.js for the APIs.

### backend-prod

Similar to the `backend` folder but with Keycloak middleware added for production.

### certs

Contains the certificate keys for the website.

### keycloak_back

The PostgreSQL dump file of Keycloak and `restoration.sh` script to restore the database.

### Docker Configuration Files

- `docker-compose.yml`: Contains configuration for all containers.
- `Docker.apache.ext`: Custom image for Apache.
- `Docker.postgres`: Custom image for PostgreSQL for Keycloak.

## Backend Source Code

-Configuration Files

### `backend/src/configs`

Contains configuration files for Swagger documentation and Keycloak middleware.

### `backend/src/models`

Contains all ORM models.

### `backend/src/services`

Contains all services that interact with the Models.

### `backend/src/redis`

Contains the Redis publisher and subscriber for logs.

### `backend/src/utilities`

Contains the database connection utilities.

### `backend/src/rest`

Contains all the private and public endpoints.


### `backend/src/www/bin`

Contains the HTTP server that launches the application.

### `backend/src/app.js`

Contains all the imported routes and Swagger setup.

### `backend/src/views`

Contains all the frontend views built with Jade.

## Docker Setup

### `Dockerfile`

Used to build the Node.js application.


