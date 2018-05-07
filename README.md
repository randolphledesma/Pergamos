[![CircleCI](https://circleci.com/gh/randolphledesma/Pergamos.svg?style=svg)](https://circleci.com/gh/randolphledesma/Pergamos) [![Swift](https://img.shields.io/badge/swift-4.1-blue.svg)](https://github.com/randolphledesma/Pergamos) [![Platforms](https://img.shields.io/badge/platforms-linux%20%7C%20osx-lightgrey.svg)](https://github.com/randolphledesma/Pergamos) [![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://en.wikipedia.org/wiki/MIT_License)

## Developing project on Docker

Clone project:
```
git clone https://github.com/randolphledesma/Pergamos.git
```

Map localhost port with VirtualBox  (Optional)
```
VBoxManage modifyvm "default" --natpf1 "tcp-port9191,tcp,,9191,,9191"
```

Create local docker container:
```
docker run --name vapordev -ti -v $(pwd):/projects -p 9191:8080 swift:4.1 /bin/bash
```

Within docker container prompt:
```
# cd /projects/pergamos
# ./windows_docker_tmp_hardlink.sh
# cd /tmp/pergamos
```

## Build and run project

```
swift run Run serve -H 0.0.0.0 -p 8080
```

## Testing endpoint
```
curl -sSL http://localhost:9191/hash/me
```