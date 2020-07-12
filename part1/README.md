### 1.1

```bash
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS               NAMES
8f16f088ed6c        couchbase           "/entrypoint.sh couc…"   49 seconds ago      Exited (0) 12 seconds ago                       priceless_galileo
85ce6c0a8b0f        redis               "docker-entrypoint.s…"   11 minutes ago      Exited (0) 8 seconds ago                        peaceful_wu
5cb9b8984d1c        nginx               "/docker-entrypoint.…"   11 minutes ago      Up 11 minutes               80/tcp              modest_carson
```

### 1.2

```bash
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
5cb9b8984d1c        nginx               "/docker-entrypoint.…"   17 minutes ago      Up 17 minutes       80/tcp              modest_carson

$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
nginx               latest              2622e6cca7eb        12 days ago         132MB
```

### 1.3
```bash
$ docker run -it devopsdockeruh/pull_exercise
Give me the password: basics
You found the correct password. Secret message is:
"This is the secret message"
```

### 1.4

```bash
$ docker run -d devopsdockeruh/exec_bash_exercise
$ docker exec -it 4ec072fdb17d bash
root@4ec072fdb17d:/usr/app# tail -f ./logs.txt
"Docker is easy"
```

### 1.5

```bash
$ docker run -it --rm --name looper ubuntu:16.04 sh -c 'apt update && apt install -y curl && echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website;'
```

### 1.6

```Dockerfile
FROM devopsdockeruh/overwrite_cmd_exercise

CMD ["-c"]
```

```bash
$ docker build -t docker-clock .
$ docker run -it --rm docker-clock
```

### 1.7

```Dockerfile
FROM ubuntu:16.04

WORKDIR /app

RUN apt-get update && apt-get install -y curl

COPY script.sh .
RUN chmod +x ./script.sh

CMD ["./script.sh"]
```

```bash
$ docker build -t curler .
$ docker run -it --rm curler
```


### 1.8

```bash
$ touch /tmp/logs.txt

$ docker run -v /tmp/logs.txt:/usr/app/logs.txt --rm devopsdockeruh/first_volume_exercise
```


### 1.9

```bash
$ docker run -p 80:80 devopsdockeruh/ports_exercise
```


### 1.10

```Dockerfile
FROM ubuntu:16.04

WORKDIR /app

RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -y nodejs

COPY package.json /app/package.json
RUN npm install

COPY . /app

EXPOSE 5000

CMD ["npm", "start"]
```

```bash
$ docker build -t frontend-example .
$ docker run --rm -p 5000:5000 frontend-example
```

### 1.11

```Dockerfile
FROM ubuntu:16.04

WORKDIR /app

RUN apt-get update && apt-get install -y curl

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -y nodejs

COPY package.json /app/package.json
RUN npm install

COPY . .

EXPOSE 8000

CMD ["npm", "start"]
```

```bash
$ docker build -t backend-example .
$ docker run --rm -v $(pwd)/logs.txt:/app/logs.txt -p 8000:8000 backend-example
```


### 1.12

```Dockerfile
FROM ubuntu:16.04

WORKDIR /app

RUN apt-get update && apt-get install -y curl

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -y nodejs

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 8000
ENV FRONT_URL=http://localhost:5000

CMD ["npm", "start"]
```

```bash
$ docker build -t backend-example .
$ docker run --rm -p 8000:8000 backend-example
```

```Dockerfile
FROM ubuntu:16.04

WORKDIR /app

RUN apt-get update && apt-get install -y curl

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -y nodejs

COPY package*.json ./
RUN npm install

COPY . /app

EXPOSE 5000
ENV API_URL=http://localhost:8000

CMD ["npm", "start"]
```

```bash
$ docker build -t frontend-example .
$ docker run --rm -p 5000:5000 frontend-example
```


### 1.13

```Dockerfile
FROM openjdk:8

WORKDIR /app

COPY . /app
RUN ./mvnw package

EXPOSE 8080

CMD ["java", "-jar", "./target/docker-example-1.1.3.jar"]
```

```bash
$ docker build -t spring-example .
$ docker run --rm -p 8080:8080 spring-example
```

### 1.14

```Dockerfile
FROM ruby:2.6.0

WORKDIR /app

RUN gem install bundler

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app

RUN apt-get update && apt-get install -y nodejs
RUN rails db:migrate

EXPOSE 3000

CMD ["rails", "s"]
```

```bash
$ docker build -t rails-example .
$ docker run --rm -p 3000:3000 rails-example
```

### 1.15

https://hub.docker.com/r/thangnv2212/wordcloud

### 1.16

https://heroku-example-devopsdockeruh.herokuapp.com/

### 1.17

Skipped
