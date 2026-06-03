FROM mysql:8
RUN echo "[mysqld]" >> /etc/mysql/my.cnf
RUN echo "sql_mode=''" >> /etc/mysql/my.cnf
RUN echo "slow_query_log=1" >> /etc/mysql/my.cnf
RUN echo "slow_query_log_file=/var/log/mysql/slow.log" >> /etc/mysql/my.cnf
RUN echo "long_query_time=2" >> /etc/mysql/my.cnf
RUN echo "mysql_native_password=ON" >> /etc/mysql/my.cnf
