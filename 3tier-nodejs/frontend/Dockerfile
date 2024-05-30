FROM node:14
WORKDIR /app
ENV PATH /app/node_module/.bin:$PATH
COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
CMD ["npm", "start"]