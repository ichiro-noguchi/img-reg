FROM weseek/growi:latest


ENV APP_DIR /opt/growi
ENV DOCKERIZE_VERSION v0.6.1
RUN apk add --no-cache --virtual .dl-deps curl \
    && curl -SLk https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        | tar -xz -C /usr/local/bin \
    && apk del .dl-deps

RUN apk add python

WORKDIR ${APP_DIR}
ADD jojo.scss /opt/growi/src/client/styles/scss/theme/
ADD CustomizeThemeOptions.jsx /opt/growi/src/client/js/components/Admin/Customize/
ADD webpack.common.js /opt/growi/config/

RUN yarn && yarn run build:prod
