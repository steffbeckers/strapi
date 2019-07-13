FROM node:lts

WORKDIR /app

COPY . .

RUN chmod +x ./strapi.sh

RUN echo "unsafe-perm = true" >> ~/.npmrc

RUN npm install -g strapi@beta

RUN npm install

# RUN npm run build

EXPOSE 1337

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s \
      CMD node /app/healthcheck.js

CMD ["./strapi.sh"]
