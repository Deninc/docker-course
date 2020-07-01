### 2.1

```yml
version: '3'

services:
  first_volume:
    image: devopsdockeruh/first_volume_exercise
    volumes:
      - /tmp/logs.txt:/usr/app/logs.txt
```


### 2.2

```yml
version: '3'

services:
  ports_exercise:
    image: devopsdockeruh/ports_exercise
    ports:
      - 80:80
```

### 2.3

```yml
version: '3'

services:
  backend:
    image: backend-example
    ports:
      - 8000:8000

  frontend:
    image: frontend-example
    ports:
      - 5000:5000
```


### 2.4

```bash
$ docker-compose up --scale compute=3
```

### 2.5

```yml
version: '3'

services:
  redis:
    image: redis

  backend:
    image: backend-example
    ports:
      - 8000:8000
    environment:
      - REDIS=redis

  frontend:
    image: frontend-example
    ports:
      - 5000:5000
```

### 2.6

```yml
version: '3'

services:
  redis:
    image: redis
    restart: unless-stopped

  postgres:
    image: postgres
    restart: unless-stopped
    environment:
      POSTGRES_PASSWORD: example

  backend:
    image: backend-example
    ports:
      - 8000:8000
    environment:
      - REDIS=redis
      - DB_HOST=postgres
      - DB_USERNAME=postgres
      - DB_PASSWORD=example

    depends_on:
      - redis
      - postgres

  frontend:
    image: frontend-example
    ports:
      - 5000:5000
    depends_on:
      - backend
```

### 2.7

```yml
version: '3'

services:
  ml-backend:
    build: ./ml-kurkkumopo-backend
    image: ml-backend
    ports:
      - 5000:5000
    volumes:
      - model:/src/model

  ml-frontend:
    build: ./ml-kurkkumopo-frontend
    image: ml-frontend
    ports:
      - 3000:3000

  ml-training:
    build: ./ml-kurkkumopo-training
    image: ml-training
    volumes:
      - model:/src/model
      - /src/imgs

volumes:
  model:
```

### 2.8

```yml
version: '3'

services:
  redis:
    image: redis
    restart: unless-stopped

  postgres:
    image: postgres
    restart: unless-stopped
    environment:
      POSTGRES_PASSWORD: example

  backend:
    image: backend-example
    ports:
      - 8000:8000
    environment:
      - REDIS=redis
      - DB_HOST=postgres
      - DB_USERNAME=postgres
      - DB_PASSWORD=example

    depends_on:
      - redis
      - postgres

  frontend:
    image: frontend-example
    ports:
      - 5000:5000
    depends_on:
      - backend

  nginx:
    image: nginx
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    ports:
      - 80:80
    depends_on:
      - frontend
      - backend
```

### 2.9

```yml
version: '3'

services:
  redis:
    image: redis
    restart: unless-stopped
    volumes:
      - ./cache:/data

  postgres:
    image: postgres
    restart: unless-stopped
    environment:
      POSTGRES_PASSWORD: example
    volumes:
      - ./database:/var/lib/postgresql/data

  backend:
    image: backend-example
    ports:
      - 8000:8000
    environment:
      - REDIS=redis
      - DB_HOST=postgres
      - DB_USERNAME=postgres
      - DB_PASSWORD=example

    depends_on:
      - redis
      - postgres

  frontend:
    image: frontend-example
    ports:
      - 5000:5000
    depends_on:
      - backend
```

### 2.10

Skipped
