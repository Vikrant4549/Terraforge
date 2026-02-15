# 1. Use official Node base image
FROM node:18-alpine

# 2. Set working directory inside container 
WORKDIR /app

# 3. Copy package files first
COPY package*.json ./

# 4. Install dependencies
RUN npm install --production

# 5. Copy rest of the application code
COPY . . 

# 6. Expose the port
EXPOSE 3000

# 7. Start the application
CMD ["npm", "start"]


# docker build - image
# docker run - container
# docker images
# docker ps - will show running containers
# docker tag terraforge-app terraforge-app:v1

