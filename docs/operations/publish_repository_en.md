# Publish Repository

```bash
curl  -X POST \
      -H 'Content-Type: application/json' \
      --data '{"Distribution": "ubuntu", "SourceKind": "local", "Sources": [{"Name": "aptly-repo"}], "Signing": {"Batch": true, "Passphrase": "changeme"}}' \
      http://localhost:8080/api/publish/repos
```