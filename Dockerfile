# node:19.2-alpine
FROM node@sha256:80844b6643f239c87fceae51e6540eeb054fc7114d979703770ec75250dcd03b

ARG DB_USER=db

COPY ./container-files/ /app/
WORKDIR /app
RUN adduser -D ${DB_USER} && \
    chgrp -R ${DB_USER} .

RUN yarn install

USER ${DB_USER}

ENTRYPOINT [ "./entrypoint.sh" ]
