# PostgreSQL 

`docker run -p 5432:5432 --name pg postgres`

PGAdmin - adds a GUI.

`docker run -p 5555:80 --name pgadmin -e PGADMIN_DEFAULT_EMAIL='nlandman' -e PGADMIN_DEFAULT_PASSWORD='password' dpage/pdadmin4`
