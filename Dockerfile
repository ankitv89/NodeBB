FROM node:lts

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

COPY install/package.json /usr/src/app/package.json

RUN npm install --only=prod && \
    npm cache clean --force

RUN mkdir local_packages && \
    cd local_packages && \
    git clone https://github.com/vrayulu/nodebb-plugin-sunbird-o&& ./nodebb activate plugin-nameidc.git && \
    cd .. && \
    npm install local_modules/nodebb-plugin-sunbird-oidc && ./nodebb activate nodebb-plugin-sunbird-oidc



COPY . /usr/src/app

ENV NODE_ENV=production \
    daemon=false \
    silent=false

EXPOSE 4567

CMD node ./nodebb build ;  node ./nodebb start
