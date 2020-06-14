# PostgreSQL 


Having never touched PostgreSQL, here's a naive dive into databases for those using Arch.

1. First, install PostgreSQL following the instructions here: https://github.com/malnvenshorn/OctoPrint-FilamentManager/wiki/Setup-PostgreSQL-on-Arch-Linux



PGAdmin - adds a GUI.

```bash
docker run -p 5432:5432 --name pg postgres

docker run -p 5555:80 --name pgadmin -e PGADMIN_DEFAULT_EMAIL='nlandman' -e \
PGADMIN_DEFAULT_PASSWORD='password' dpage/pdadmin4`
```

# Some Tips

* To list databases, type `\l`
* To change databases, type `\c database_name`
* To view a table's columns, the query is `select column_name from information_schema.columns where table_name='mytable';`
* 
