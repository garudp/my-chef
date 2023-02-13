Description
===========
Installs and configures Airflow workflow management platform.
More information about Airflow can be found here:
* https://airflow.incubator.apache.org
* https://github.com/airbnb/airflow
* https://github.com/celery/celery

Based on cookbook of [Sergey Bahchissaraitsev](http://www.bahchis.com/about/)

Requirements
============
Supported Platforms: CentOS (tested on 6.5)

Attributes
==========

Usage
=====
Check/add passwords in the airflow data bag before use.

Setup MySQL database:
For example:
```
/usr/bin/mysql -e "CREATE DATABASE airflow;"
/usr/bin/mysql -e "CREATE DATABASE celery;"
/usr/bin/mysql -e "CREATE USER 'airflow_user'@'%' IDENTIFIED BY '****';"
/usr/bin/mysql -e "CREATE USER 'celery_user'@'%' IDENTIFIED BY '****';"
/usr/bin/mysql -e "GRANT ALL PRIVILEGES ON airflow.* TO 'airflow_user'@'%'; FLUSH PRIVILEGES;"
/usr/bin/mysql -e "GRANT ALL PRIVILEGES ON celery.* TO 'celery_user'@'%'; FLUSH PRIVILEGES;"
```

Setup Postgres database:
For example:
```
# create user node['airflow']['db_user'] with encrypted password 'very_strong_password_from_databag';
# create database node['airflow']['db_name'];
# grant all privileges on database node['airflow']['db_name'] to node['airflow']['db_user'];
# \c node['airflow']['db_name'];
# \dt # Relations check after DB init.
```

Don't forget to initialize DB:
```
# sudo -i -u <airflow_user>
$ source /etc/sysconfig/airflow && airflow initdb
```

Web Authentication: see http://pythonhosted.org/airflow/security.html

Those parameters needs to be setup in an appropriate role for proper configure metrics section in airflow.cfg:

* ```node["airflow"]["metrics"]["env"]```, possible values: "prod", "stage", this value selects tags to be added into "[metrics]" section.
* ```node["airflow"]["config"]["metrics"]["type"]```, according to pipeline name
* ```node["airflow"]["config"]["metrics"]["reporter"]```, possible values: "ElasticsearchReporter", "LoggingReporter" (default)
* ```node["airflow"]["config"]["metrics"]["hosts"]```, ES URI, e.g. "http://elasticsearch01.mars.303net.pvt:9200"
* ```node["airflow"]["config"]["metrics"]["index"]```, ES index name to write to, e.g. "metrics"
