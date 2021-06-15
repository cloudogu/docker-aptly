#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [ "${GPG_KEY}" != "" ]; then
  if [ "${PASSPHRASE}" != "" ]; then
    echo "${PASSPHRASE}" | gpg --batch --passphrase-fd 0 --import "${GPG_KEY}"
  else
    gpg --batch --import "${GPG_KEY}"
  fi
fi

# be sure public directory exists
if ! [ -d /var/lib/aptly/public ]; then
  mkdir /var/lib/aptly/public
fi

# start aptly
/usr/bin/aptly api serve
