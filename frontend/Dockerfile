# Stage 1: Build the React app
FROM node:16-alpine as build

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the app for production
RUN npm run build

# Stage 2: Serve the app with nginx
FROM nginx:stable-alpine

# Remove the default nginx configuration
RUN rm -rf /etc/nginx/conf.d/default.conf

# Copy our custom nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the production build from the previous stage into nginx's html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 3000
EXPOSE 3000

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
