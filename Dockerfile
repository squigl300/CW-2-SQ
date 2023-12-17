# Use a Node base image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of application's code
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Define the command to run app
CMD ["node", "server.js"]
