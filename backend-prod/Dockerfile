# Use the official Node.js image as the base image
FROM node:20

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Copy the wait-for-it script to the working directory
COPY wait-for-it.sh .

# Make the wait-for-it script executable
RUN chmod +x wait-for-it.sh

# Install netcat-openbsd for the wait-for-it script
#RUN apt-get update && apt-get install -y netcat-openbsd && apt-get clean

# Expose the port the app runs on
EXPOSE 4000

# Command to run the application with the DEBUG environment variable
CMD ["./wait-for-it.sh", "db:5432", "--", "sh", "-c", "DEBUG=soa-mini-twitter:* npm start"]

