FROM node
# update dependencies and install curl
## RUN apt-get update && apt-get install -y \
##     curl \
##     && rm -rf /var/lib/apt/lists/*
# Create app directory
WORKDIR /app

COPY . .
# update each dependency in package.json to the latest version
RUN npm install
RUN npm run build

# Bundle app source
COPY . /app
EXPOSE 3000
CMD [ "node", "dist/main.js" ]