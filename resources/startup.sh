#!/bin/bash
set -o errexit
set -o pipefail

if [[ -n "${GPG_KEY}" ]]; then
  if [[ -n "${PASSPHRASE}" ]]; then
    echo "${PASSPHRASE}" | gpg --batch --passphrase-fd 0 --import "${GPG_KEY}"
  else
    gpg --batch --import "${GPG_KEY}"
  fi
fi

# be sure public directory exists
if [[ ! -d /var/lib/aptly/public ]]; then
  mkdir /var/lib/aptly/public
fi

export GIN_MODE=release

# start aptly
/app/aptly/aptly api serve
