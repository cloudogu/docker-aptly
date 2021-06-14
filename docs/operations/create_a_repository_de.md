# Repository Erstellen

Damit ein Repository angelegt werden kann, muss der aptly Container vorher gestartet werden.

```bash
curl  -X POST \
      -H 'Content-Type: application/json' \
      --data '{"Name": "aptly-repo"}' \
      http://localhost:8080/api/repos
```
