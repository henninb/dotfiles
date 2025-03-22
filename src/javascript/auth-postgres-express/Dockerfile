# Use an official lightweight Node.js image.
FROM node:22-alpine

# Set the working directory in the container.
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available) to leverage Docker cache.
COPY package*.json ./

# Install production dependencies.
RUN npm install --production

# Copy the rest of your application code.
COPY . .

# Set the PORT environment variable to 80.
# ENV PORT=80

# Expose port 80 to the outside world.
# EXPOSE 80

# Start the Express app.
CMD [ "node", "server.js" ]
