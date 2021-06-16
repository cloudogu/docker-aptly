#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

REPOSITORY_NAME=testRepo
PACKAGE=ces-commons_0.4.0.deb

#
# ----------------------------------------------------------------------------------------------------------------------
#

echo "[Test] Create a repository..."

RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" \
  --request POST \
  --url http://192.168.56.2:8080/api/repos \
  --header 'Content-Type: application/json' \
  --data "{\"Name\": \"${REPOSITORY_NAME}\"}")

if [[ ${RESPONSE} != 201 ]]; then
  echo "[Test] Create a repository - FAILED! - Error code should be 201 but got ${RESPONSE}"
  exit 1
else
  echo "[Test] Create a repository - SUCCESS!"
fi

#
# ----------------------------------------------------------------------------------------------------------------------
#

echo "[Test] Delete a repository..."

RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" \
  --request DELETE \
  --header 'Content-Type: application/json' \
  --data "{\"Name\": \"${REPOSITORY_NAME}\"}" \
  --url http://192.168.56.2:8080/api/repos/"${REPOSITORY_NAME}")

if [[ ${RESPONSE} != 200 ]]; then
  echo "[Test] Delete a repository - FAILED! - Error code should be 200 but got ${RESPONSE}"
  exit 1
else
  echo "[Test] Delete a repository - SUCCESS!"
fi

#
# ----------------------------------------------------------------------------------------------------------------------
#

echo "[Test] Upload a package..."

RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" \
  --request POST \
  -F file="${PACKAGE}" \
  --url http://192.168.56.2:8080/api/files/"${PACKAGE}")

if [[ ${RESPONSE} != 200 ]]; then
  echo "[Test] Upload a package - FAILED! - Error code should be 200 but got ${RESPONSE}"
  exit 1
else
  echo "[Test] Upload a package - SUCCESS!"
fi