# Description: Dockerfile for the frontend development environment

# Use an official lightweight Node.js image
FROM node:16-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package files
COPY package*.json ./
COPY package-lock.json ./

# Clean npm cache and remove existing node_modules (fixes ENOTEMPTY errors)
# RUN npm cache clean --force && rm -rf node_modules

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Expose port 3000
EXPOSE 3000

# Set environment variable for development
ENV NODE_ENV=development

# Run the development server (typically using react-scripts start)
CMD ["npm", "start"]
