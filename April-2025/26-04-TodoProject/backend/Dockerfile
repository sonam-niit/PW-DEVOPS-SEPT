# Use Node base image
FROM node:18
# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the backend files
COPY . .

# Expose port and run the app
EXPOSE 5000
CMD ["node", "server.js"]
