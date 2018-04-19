### DESCRIPTION ###
This container provides the aptly api on port 8080 which obviously is
exposed. Aptly is configured by aptly.conf within the resources directory.

### BUILD ###
Build this container by invocing ./make
This will also provide gpg keys if the werent given in resources/aptly.pub
and resources/aptly.sec

### TEST EXAMPLE ###
curl -F file=@/home/schristann/Downloads/teamviewer_11.0.53191_i386.deb http://localhost:8080/api/files/teamviewer_11.0.53191
curl -X POST -H 'Content-Type: application/json' --data '{"Name": "aptly-repo"}' http://localhost:8080/api/repos
curl -X POST http://localhost:8080/api/repos/aptly-repo/file/teamviewer_11.0.53191
curl http://localhost:8080/api/repos/aptly-repo/packages
## NOTE - use the password you gave in gpg/gpg.sh ##
curl -X POST -H 'Content-Type: application/json' --data '{"Distribution": "wheezy", "SourceKind": "local","Sources": [{"Name": "aptly-repo"}], "Signing": {"Batch": true, "Passphrase": "changeme"}}' http://localhost:8080/api/publish/repos


# concrete example

## create repository
curl -X POST -H 'Content-Type: application/json' --data '{"Name": "cloudogu-repo"}' https://apt-api.cloudogu.com/api/repos

## upload a file
curl -F file=@dist/cesapp_0.5.1.deb https://apt-api.cloudogu.com/api/files/cesapp_0.5.1.deb

## add file to repository
curl -X POST https://apt-api.cloudogu.com/api/repos/cloudogu-repo/file/cesapp_0.5.1.deb

## publish repository
curl -X POST -H 'Content-Type: application/json' --data '{"Distribution": "ubuntu", "SourceKind": "local", "Sources": [{"Name": "cloudogu-repo"}], "Signing": {"Batch": true, "Passphrase": "changeme"}}' https://apt-api.cloudogu.com/api/publish/repos
