# Create a Repository

In order to create a repository the aptly container must be started first.

```bash
curl  -X POST \
      -H 'Content-Type: application/json' \
      --data '{"Name": "aptly-repo"}' \
      http://localhost:8080/api/repos
```