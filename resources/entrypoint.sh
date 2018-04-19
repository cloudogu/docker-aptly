#!/bin/bash

if [ "${GPG_KEY}" != "" ]; then
  if [ "${PASSPHRASE}" != "" ]; then
    echo "${PASSPHRASE}" | gpg --batch --passphrase-fd 0 --import "${GPG_KEY}"
  else
    gpg --batch --import "${GPG_KEY}"
  fi
fi

# besure public directory exists
if ! [ -d /var/lib/aptly/public ]; then
  mkdir /var/lib/aptly/public
fi

# execute parameters
exec "$@"
