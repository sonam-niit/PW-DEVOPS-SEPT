FROM node:22.3.0-alpine3.20

COPY package*.json ./
RUN npm install

COPY . .
EXPOSE 5000

ENTRYPOINT ["npm","start"]