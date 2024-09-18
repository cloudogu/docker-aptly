# Release Process

to release a new version, do the following:
- merge your changes into develop via github PR
- on develop, execute `git flow release start x.x.x-x`
- follow the steps of git flow
- build the docker image with: `docker build . -t cloudogu/docker-aptly:x.x.x-x`
- login to docker hub, get credentials with: `gopass show cloudogu/websites/hub.docker.com/cloudogu2hub`
- push image with: `docker push cloudogu/docker-aptly:x.x.x-x`