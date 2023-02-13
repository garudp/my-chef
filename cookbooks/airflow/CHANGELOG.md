# CHANGELOG for airflow

This file is used to list changes made in each version of airflow cookbook.

## 0.0.1:

* Initial release of Airflow cookbook

## 0.0.2:

* Unused resoure file was deleted

## 0.0.3:

* Security fix

## 0.0.4:

* Service user was changed: airflow -> persona

## 0.0.5:

* Changed init system: System V -> runit. Service user airflow reactivated. Cosmetics

## 0.0.6:

* Review fixes. Mysql server recipe removed

## 0.0.7:

* Review fixes. Cosmetics

## 0.0.8:

* Review fixes. Security fixes. Password based authentication added. Cosmetics

## 0.0.9:

* Review fixes. Cosmetics

## 0.0.11:

* LDAP support for airflow webserver

## 0.0.12:

* Added sad and airflow contrib packages. Removed "db_path" attributes from default attributes due to chef's bug.

## 0.0.13:

* airflow-worker-fraud runned under persona user.

## 1.0.0

* Release

## 1.0.1

* LDAP authentication enabled by default

## 1.0.2

* Split databags for prod and stage

Deploys Apache Airflow and performs configuration.

## 1.0.3

* Add dedicated queue for workers

## 1.0.4

* Included recipe "logrotate", added some params for one

## 1.1.0

* Add deployment user/group who are owners of dag/archive sub-directories
* Allow only deploy user to write to dag sub-directory

## 1.2.0

* [AUD-3836] Add metrics section into airflow workers config

## 1.2.1

* [AUD-3893] Removed default values for hosts, index and type from metrics section

## 1.3.0

* [AUD-3894] Removed custom log rotation management resources in favor of runit options

## 1.4.0

* [AUD-4122] Added a couple of attributes for fraud monitoring

## 1.5.0

* [AUD-4182] Support airflow-worker-dev-stage role
* Move databag secure key to attributes

## 1.6.0

* [AUD-4176] Airflow scheduler needs to be autorestarted in case of stuck
* Added zabbix configuration file in order to enable remote commands execution

## 1.7.0

* [AUD-4213] Zabbix monitoring for DAGs

## 2.0.0

* [AUD-4305] Switch to posgresql backend

## 2.0.1

* [AUD-4345] Updated zabbix item key in airflow_local_settings.py

## 2.1.0

* [AUD-4347] Update airflow_local_settings.py

## 2.1.1

* [AUD-4347] Fix for airflow_local_settings.py

## 2.1.2

* [AUD-4347] Fix parallel tasks for airflow_local_settings.py

## 2.2.0

* [AUD-4019] Some config parameters added

## 2.2.1

* Fix a modifying ldap user

## 2.3.0

* Enable backfilling by default

## 2.4.0

* Include recipe user into default

## 2.5.0

* Add monitoring retries for import pipelines

## 2.5.1

* [AUD-4673] fixed error handling for the airflow::user recipe

## 2.6.0

* [AUD-4617] scheduler logs rotate script

## 2.6.1

* [AUD-4786] Remove retry alert from pipeline monitoring

## 2.7.0

* [AUD-4578] Remove additional timestamp in runit managed log

## 2.8.0

* [AOS-5303] Add core parameter 'default_timezone'

## 2.9.0

* [AOS-5576] Added /var/lib/airflow/flags

## 2.9.1

* [AOS-5576] Fixed attribute name, because otherwise it will be used in /var/lib/airflow/airflow.cfg

## 2.10.0

* [AOS-5811] Create a test master/worker host for Airflow 1.10 and deploy it there
* README changes

## 2.11.0

* [AOS-5397] Design and implement a log rotation scheme for airflow's instances
* Implementing with a DAG

## 2.12.0

* [AOS-5397] Design and implement a log rotation scheme for airflow's instances
* Implementing with cron

## 2.13.0

* [AOS-5903] Config option "cacert" was added to airflow.cfg

## 2.14.0

* [AOS-6747] Add HADOOP_CONF_DIR to environment variables

## 2.15.0

* [AOS-6959] Fix airflow's webserver pidfile location
