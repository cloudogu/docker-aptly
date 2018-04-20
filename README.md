# docker aptly

This container provides the aptly api on port 8080 which obviously is exposed. Aptly is configured by aptly.conf within the resources directory.

# build

```bash
docker build -t cloudogu/aptly:latest .
```

# usage

```bash
# stat the container
docker run -v /some/host/path:/var/lib/aptly -p 8080:8080 cloudogu/aptly:latest

# create a repository
curl -X POST -H 'Content-Type: application/json' --data '{"Name": "aptly-repo"}' http://localhost:8080/api/repos

# upload a package
curl -F file=@dist/hitchhiker_0.5.1.deb http://localhost:8080/api/files/hitchhiker_0.5.1.deb

# add package to the repository
curl -X POST http://localhost:8080/api/repos/cloudogu-repo/file/hitchhiker_0.5.1.deb

# publish repository
curl -X POST -H 'Content-Type: application/json' --data '{"Distribution": "ubuntu", "SourceKind": "local", "Sources": [{"Name": "aptly-repo"}], "Signing": {"Batch": true, "Passphrase": "changeme"}}' http://localhost:8080/api/publish/repos
```
