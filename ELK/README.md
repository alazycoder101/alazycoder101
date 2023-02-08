```bash
# .env
VERSION=8.6.1

docker compose convert
docker compose --env-file ./doesnotexist/.env.dev  convert
es      | ERROR: [1] bootstrap checks failed. You must address the points described in the following [1] lines before starting Elasticsearch.
es exited with code 78


Reference
---
1. https://github.com/geektime-geekbang/geektime-ELK
```
