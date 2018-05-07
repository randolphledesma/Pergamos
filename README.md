[![CircleCI](https://circleci.com/gh/randolphledesma/Pergamos.svg?style=svg)](https://circleci.com/gh/randolphledesma/Pergamos)

## Developing project on Docker

```
docker run --name vapordev -ti -v $(pwd):/projects -p 9191:8080 swift:4.1 /bin/bash
```

```sh
# cd /pergamos
# ./windows_docker_tmp_hardlink.sh
# cd /tmp/pergamos
```

## Build and run project

```sh
swift run Run serve -H 0.0.0.0 -p 8080
```