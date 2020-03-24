# PostgreSQL 

PGAdmin - adds a GUI.

```bash
docker run -p 5432:5432 --name pg postgres

docker run -p 5555:80 --name pgadmin -e PGADMIN_DEFAULT_EMAIL='nlandman' -e PGADMIN_DEFAULT_PASSWORD='password' dpage/pdadmin4`
```
