[circleci_logo]: https://circleci.com/gh/stlouisn/radarr_docker.svg?style=svg
[circleci_url]: https://app.circleci.com/pipelines/github/stlouisn/radarr_docker

[docker_version_logo]: http://img.shields.io/docker/v/stlouisn/radarr/latest?arch=arm64
[docker_version_url]: https://hub.docker.com/r/stlouisn/radarr

[docker_size_logo]: http://img.shields.io/docker/image-size/stlouisn/radarr/latest
[docker_size_url]: https://hub.docker.com/r/stlouisn/radarr

[docker_pulls_logo]: https://img.shields.io/docker/pulls/stlouisn/radarr
[docker_pulls_url]: https://hub.docker.com/r/stlouisn/radarr

[license_logo]: https://img.shields.io/github/license/stlouisn/radarr_docker
[license_url]: https://github.com/stlouisn/radarr_docker/blob/main/LICENSE

### Radarr Docker

[![Build Status][circleci_logo]][circleci_url]
[![Docker Version][docker_version_logo]][docker_version_url]
[![Docker Size][docker_size_logo]][docker_size_url]
[![Docker Pulls][docker_pulls_logo]][docker_pulls_url]
[![License][license_logo]][license_url]

Radarr Docker is a movie downloader and organizer that is configured for use within Docker containers and offers:

- interoperabity with other servarr containers
- RSS feeds
- monitors for new releases and can be configured with certain criteria
- organizing movie library
  
```docker
docker pull stlouisn/radarr:latest
docker run stlouisn/radarr:latest /bin/bash -l
```

#### Links

*https://community.radarr.net/radarr*
