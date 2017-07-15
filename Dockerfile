# written by Benoit Sarda
# creates a postgresql 9.5.4, working with CentOS 7.2 1511. compatible with puppetdb and foreman.
#
#   bsarda <b.sarda@free.fr>
#
FROM centos:7
LABEL maintainer "b.sarda@free.fr"

# declare vars
ENV ADMIN_USER=admin \
    ADMIN_PASSWORD=admin \
    PGDATA=/var/lib/pgsql/9.5/data \
    LANG=en_US.UTF8

# expose for pgadmin or other sql tool
EXPOSE 5432

# add file, replace, chown, chmod...
ADD ["conf/pg_hba.conf", \
    "init.sh", \
    "stop.sh", \
    "/tmp/" ]

# install packages
RUN yum clean all && \
    yum install -y https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-redhat95-9.5-2.noarch.rpm  && \
    sed -i.bkp 's@\(gpgkey=.*\)@\1\nexclude=postgresql*@gi' /etc/yum.repos.d/CentOS-Base.repo && \
    yum install -y postgresql95 postgresql95-server postgresql95-contrib && \
    mv /tmp/init.sh /usr/local/bin/init.sh && mv /tmp/stop.sh /usr/local/bin/stop.sh && \
    chmod 750 /usr/local/bin/init.sh && chmod 750 /usr/local/bin/stop.sh && \
    chown -Rf postgres:postgres $PGDATA && \
    su postgres -c "/usr/pgsql-9.5/bin/initdb --locale $LANG -D $PGDATA" && \
    sed -i.bkp 's@#listen_addresses.*@listen_addresses = '"'"'*'"'"'@gi' $PGDATA/postgresql.conf && \
    mv /tmp/pg_hba.conf $PGDATA -f && chown -f postgres:postgres $PGDATA/pg_hba.conf

# add volumes for config, logs, and db
VOLUME /var/lib/pgsql/9.5/data

CMD ["/usr/local/bin/init.sh"]
