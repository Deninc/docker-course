### Build
```bash
$ docker build . -t build-repo
```

### Run

```bash
$ export DOCKER_USER='dockerhub-user'
$ export DOCKER_PASSWORD='dockerhub-password'

$ docker run --rm \
    -e DOCKER_USER -e DOCKER_PASSWORD \
    -v /var/run/docker.sock:/var/run/docker.sock build-repo \
    <github-repo> <dockerhub-repo-name>
```

Example:
```bash
$ export DOCKER_USER='thangnv2212'
$ export DOCKER_PASSWORD='******'

$ docker run --rm \
    -e DOCKER_USER -e DOCKER_PASSWORD \
    -v /var/run/docker.sock:/var/run/docker.sock build-repo \
    docker-hy/docker-hy.github.io test-build-repo
```

This will build the project from https://github.com/docker-hy/docker-hy.github.io then push to https://hub.docker.com/r/thangnv2212/docker-hy.github.io.
