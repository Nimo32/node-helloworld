FROM node:12-alpine3.14
WORKDIR /app
COPY package.json /app
RUN npm install --prefix
RUN npm ci --only=production && npm cache clean --force
COPY . /app
CMD node index.js
EXPOSE 8081
