### 3.1

Before optimize:
- backend-example: 349MB
- frontend-example: 525MB

After optimize:
- backend-example: 313MB
- frontend-example: 489MB

### 3.2

https://github.com/Deninc/wordCloudGenerator

### 3.3

Folder **build-repo**

### 3.4

Frontend:
```Dockerfile
FROM ubuntu:16.04

WORKDIR /app

COPY package*.json ./

RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash && \
    apt-get install -y nodejs && \
    npm install && \
    apt-get purge -y --auto-remove curl && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m app && chown app:app /app

COPY . .

EXPOSE 5000
ENV API_URL=http://localhost:8000

USER app
CMD ["npm", "start"]
```

Backend:
```Dockerfile
FROM ubuntu:16.04

WORKDIR /app

COPY package*.json ./

RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash && \
    apt-get install -y nodejs && \
    npm install && \
    apt-get purge -y --auto-remove curl && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m app && chown app:app /app

COPY . .

EXPOSE 8000
ENV FRONT_URL=http://localhost:5000

USER app
CMD ["npm", "start"]
```

### 3.5

Before optimize:
- backend-example: 313MB
- frontend-example: 489MB

After optimize:
- backend-example: 121MB
- frontend-example: 297MB


### 3.6

```Dockerfile
# build
FROM node:10-alpine as build
WORKDIR /tmp
COPY . .
ENV API_URL=http://localhost:8000
RUN npm install && npm run build

# prod
FROM node:10-alpine
WORKDIR /home/node
COPY --from=build /tmp/dist ./dist
RUN npm install -g serve
EXPOSE 5000
USER node
CMD ["serve", "-s", "-l", "5000", "dist"]
```

### 3.7

Before:
```Dockerfile
FROM rocker/shiny:3.5.3

RUN apt-get update && apt-get install -y libxml2-dev
RUN R -e "install.packages(c('wordcloud', 'tm'))"

WORKDIR /srv/shiny-server/
COPY server.R ui.R ./

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]
```
Image size: 1.57GB

After:
```Dockerfile
# build
FROM rocker/shiny:3.5.3 as builder
RUN apt-get update && apt-get install -y --no-install-recommends libxml2-dev && \
    R -e "install.packages(c('wordcloud', 'tm'))"

# prod
FROM rocker/r-ver:3.5.3
COPY --from=builder /usr/local/bin/R /usr/local/bin/R
COPY --from=builder /usr/local/lib/R /usr/local/lib/R
COPY --from=builder /usr/local/bin/Rscript /usr/local/bin/Rscript
COPY --from=builder /opt/shiny-server /opt/shiny-server
COPY --from=builder /etc/shiny-server/shiny-server.conf /etc/shiny-server/shiny-server.conf

WORKDIR /srv/shiny-server/
COPY server.R ui.R ./

RUN mkdir -p /var/log/shiny-server && \
    mkdir -p /var/lib/shiny-server && \
    ln -s /opt/shiny-server/bin/shiny-server /usr/bin/shiny-server && \
    useradd -m shiny && \
    chown shiny:shiny /srv/shiny-server/ && \
    chown shiny:shiny /var/log/shiny-server && \
    chown shiny:shiny /var/lib/shiny-server

EXPOSE 3838
USER shiny
CMD ["shiny-server"]
```
Image size: 1.2GB and running as non-root

### 3.8

Skipped
