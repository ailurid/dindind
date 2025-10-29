# syntax=docker/dockerfile:1-labs
FROM docker:dind AS docker

RUN apk add bash

RUN \
  # --network=host \ # todo?
  --security=insecure \
  <<EOF
#!/bin/bash
# turn on bash's job control
set -m
# Start the dockerd daemon and put it in the background
dockerd-entrypoint.sh &
# Wait until the daemon comes up
iter=1
max_iter=5
while ! docker ps && [[ $iter -le $max_iter ]]; do
  echo "Waiting for docker daemon (attempt $iter)..."
  iter=$((iter + 1))
  sleep 2
done
echo "Maybe docker daemon is now running?"
EOF

FROM node:16-alpine AS node

VOLUME /src/dist

COPY . .

WORKDIR /src

RUN \
  --mount=type=bind,from=docker,source=/usr/local/bin/docker,target=/usr/bin/docker \
  --security=insecure \
  npm install --omit=dev

EXPOSE 8080
ENTRYPOINT ["npm", "start"]
