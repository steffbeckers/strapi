FROM node

RUN echo "unsafe-perm = true" >> ~/.npmrc

WORKDIR /app

COPY package*.json ./

RUN npm install

# RUN npm install -g strapi@beta

RUN npm rebuild node-sass

COPY . .

RUN NODE_ENV=production npm run build

# HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
#       CMD node /app/healthcheck.js

RUN chmod +x ./strapi.sh

CMD ["./strapi.sh"]

EXPOSE 1337
