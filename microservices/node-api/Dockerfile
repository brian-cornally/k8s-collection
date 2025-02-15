# Use the official Node.js image from Docker Hub with a specific version
FROM node:23-alpine

# Create a directory for the application in the container
RUN mkdir -p /opt/app

# Set the working directory inside the container to /opt/app
WORKDIR /opt/app

# Copy package.json and package-lock.json to the container's working directory
COPY src/package.json src/package-lock.json .

# Install Node.js dependencies based on the package.json and package-lock.json
RUN npm install

# Copy the entire contents of the 'src' directory to the container's working directory
COPY src/ .

# Expose port 3000 to allow external access to the application
EXPOSE 3000

# Specify the command to run when the container starts (start the application)
CMD ["npm", "start"]