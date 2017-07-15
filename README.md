# docker-postgresql

Docker container with postgresql 9.5.4, runs under centos 7.2 1511.  
usage:  
```
docker run -d --name db --restart unless-stopped -p 5432:5432 bsarda/postgresql:9.5
docker run -d --name db --restart unless-stopped -p 45432:5432 --env ADMIN_USER=su --env ADMIN_PASSWORD='P@ssw0rd!' bsarda/postgresql:9.5
```
the data location is /var/lib/pgsql/9.5/data inside the container and exported as a volume.  

Sample usage:  
```
docker exec db su postgres -c 'psql -c "\du"'  
psql -h localhost -p 5432 -c "\du" -U su  
```





docker exec postgres su postgres -c 'psql -c "\du"'  

create database ejbca;grant all privileges on ejbca.* to 'ejbca'@'localhost' identified by 'ejbca';flush privileges;"
docker exec postgres echo $ADMIN_USER
docker exec postgres su postgres -c "psql --command \"ALTER USER su with CREATEDB;ALTER USER su with CREATEROLE;ALTER USER su with CREATEUSER;\""

docker run --rm -it --name pki --env DB_USER=ejbca --env DB_PASSWORD='P@ssw0rd!' --env DB_URL=jdbc:postgresql://192.168.63.5:45432/ejbca --env DB_DRIVER=org.postgresql.Driver bsarda/ejbca /bin/bash
