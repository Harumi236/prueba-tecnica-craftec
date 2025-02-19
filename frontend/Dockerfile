# Description: Dockerfile for the frontend

# Use the official image as a parent image
FROM node:alpine 

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package.json ./
COPY package-lock.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the application
RUN npm run build

# Make the port 3000 available to the world outside this container
EXPOSE 3000

# Run the application
CMD [ "npm", "start" ]

