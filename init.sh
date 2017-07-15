#!/bin/bash

touch /tmp/letitrun
if [ ! -f $PGDATA/initialized ]; then
        echo "This is the first launch - will init database and su access"
        su postgres -c "/usr/pgsql-9.5/bin/pg_ctl start -D $PGDATA -w -t 300"
        echo "Creating user:$ADMIN_USER , with password: $ADMIN_PASSWORD ..."
        su postgres -c "psql --command \"CREATE USER $ADMIN_USER WITH SUPERUSER PASSWORD '$ADMIN_PASSWORD';ALTER USER $ADMIN_USER with CREATEDB;ALTER USER $ADMIN_USER WITH CREATEROLE;ALTER USER $ADMIN_USER WITH CREATEUSER;\""
        su postgres -c "createdb -O $ADMIN_USER $ADMIN_USER"
        echo "Done ! DB Started !"
        # create flag file
        touch $PGDATA/initialized;
else
        echo "Database already initialized, no need to reinit - just start."
        # then start it.
        su postgres -c "/usr/pgsql-9.5/bin/postgres -D $PGDATA"
        echo "DB Started !"
fi

echo "Will intercept traps for redirecting the SIGTERM"
# wait in an infinite loop for keeping alive pid1
trap '/bin/sh -c "/usr/local/bin/stop.sh"' SIGTERM
while [ -f /tmp/letitrun ]; do sleep 1; done
exit 0;
