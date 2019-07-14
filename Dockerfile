FROM node:lts

WORKDIR /app

COPY . .

RUN chmod +x ./strapi.sh

RUN echo "unsafe-perm = true" >> ~/.npmrc

RUN npm install -g strapi@beta

RUN npm install

RUN NODE_ENV=test npm run build

EXPOSE 1337

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
      CMD node /app/healthcheck.js

CMD ["./strapi.sh"]
