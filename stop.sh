echo "WE'RE ABOUT TO STOP RIGHT NOW !"
# stop database
kill -INT $(head -1 $PGDATA/postmaster.pid)
echo "Everything is properly stopped, we can exit"
rm -f /tmp/letitrun
