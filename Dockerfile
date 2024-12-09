# Use an official Node.js runtime as the base image
FROM node:23.2.0-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the application
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Start the Nuxt.js app
CMD ["npm", "run", "start"]
