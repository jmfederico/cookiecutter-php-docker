FROM node:{{ cookiecutter.node_version }}-alpine

WORKDIR /srv/app

COPY package*.json ./
RUN npm install

EXPOSE 55555/tcp

CMD ["npm", "run", "start"]
