default['airflow']['version'] = nil
default['airflow']['databag_item'] = nil
default['airflow']['databag_secret_key'] = '/etc/chef/airflow-encrypted-data-bag-secret'
default['airflow']['user'] = 'airflow'
default['airflow']['group'] = 'airflow'
default['airflow']['deploy_user'] = 'gd-deploy'
default['airflow']['deploy_group'] = 'gd-deploy'
default['airflow']['user_home_directory'] = '/var/lib/airflow'
default['airflow']['shell'] = '/sbin/nologin'
default['airflow']['directories_mode'] = '0775'
default['airflow']['config_file_mode'] = '0644'
default['airflow']['java_home'] = '/usr/java/latest'
default['airflow']['bin_path'] = '/opt/python-envs/airflow/bin'
default['airflow']['env_path'] = '/etc/sysconfig/airflow'
default['airflow']['run_path'] = '/var/run/airflow'
default['airflow']['log_path'] = '/var/log/service/airflow'
default['airflow']['log_config']['size'] = 100000000
default['airflow']['log_config']['num'] = 10
default['airflow']['log_config']['age'] = 86400
default['airflow']['scheduler_log_path'] = '/var/log/service/airflow/scheduler'
default['airflow']['worker_log_path'] = '/var/log/service/airflow/worker'
default['airflow']['webserver_log_path'] = '/var/log/service/airflow/webserver'
default['airflow']['flower_log_path'] = '/var/log/service/airflow/flower'
default['airflow']['pid_path'] = '/var/run/airflow'
default['airflow']['worker_queue'] = 'default'
default['airflow']['db_user'] = 'airflow_stage'
default['airflow']['db_name'] = 'airflow_stage'
default['airflow']['db_pass'] = nil
default['airflow']['db_host'] = 'localhost'
default['airflow']['db_port'] = '5432'
default['airflow']['celery']['db_user'] = 'celery_stage'
default['airflow']['celery']['db_name'] = 'celery_stage'
default['airflow']['celery']['db_host'] = 'localhost'
default['airflow']['celery']['db_port'] = '5432'
default['airflow']['celery']['broker_port'] = '5672'
default['airflow']['rabbitmq']['db_host'] = 'localhost'
default['airflow']['rabbitmq']['db_user'] = 'airflow'
default['airflow']['rabbitmq']['db_user_tag'] = 'testing'
default['airflow']['metrics']['env'] = 'default'
default['airflow']['db_host_fraud'] = 'mysql.mars.303net.pvt'
default['airflow']['db_user_fraud'] = 'fraud_user'
default['airflow']['db_pass_fraud'] = nil
default['airflow']['db_name_fraud'] = 'fraud'
default['airflow']['use_airflow_local_settings'] = false
default['airflow']['scheduler']['logs_keep_days'] = '30'
default['airflow']['worker']['logs_keep_days'] = '180'

# Configurations stated below are required for this cookbook and will be written to airflow.cfg, you can add more config by using structure like:
# default['airflow']['config']['CONFIG_SECTION']['CONFIG_ENTRY']

# Core
default['airflow']['config']['core']['airflow_home'] = node['airflow']['user_home_directory'].to_s
default['airflow']['config']['core']['dags_folder'] = "#{node['airflow']['config']['core']['airflow_home']}/dags"
default['airflow']['config']['core']['dags_archive_folder'] = "#{node['airflow']['config']['core']['airflow_home']}/archive"
default['airflow']['config']['core']['base_log_folder'] = "#{node['airflow']['config']['core']['airflow_home']}/logs"
default['airflow']['flags_dir'] = "#{node['airflow']['config']['core']['airflow_home']}/flags"
default['airflow']['config']['core']['remote_base_log_folder'] = nil
default['airflow']['config']['core']['remote_log_conn_id'] = nil
default['airflow']['config']['core']['encrypt_s3_logs'] = 'False'
default['airflow']['config']['core']['executor'] = 'CeleryExecutor'
default['airflow']['config']['core']['sql_alchemy_conn'] = 'secret_word'
default['airflow']['config']['core']['sql_alchemy_pool_size'] = 5
default['airflow']['config']['core']['sql_alchemy_pool_recycle'] = 3600
default['airflow']['config']['core']['parallelism'] = 32
default['airflow']['config']['core']['dag_concurrency'] = 16
default['airflow']['config']['core']['non_pooled_task_slot_count'] = 128
default['airflow']['config']['core']['max_active_runs_per_dag'] = 16
default['airflow']['config']['core']['load_examples'] = 'False'
default['airflow']['config']['core']['plugins_folder'] = "#{node['airflow']['config']['core']['airflow_home']}/plugins"
default['airflow']['config']['core']['donot_pickle'] = 'False'
default['airflow']['config']['core']['dagbag_import_timeout'] = 30
default['airflow']['config']['core']['fernet_key'] = 'secret_word'
default['airflow']['config']['core']['default_timezone'] = 'utc'

# Operators
default['airflow']['config']['operators']['default_owner'] = 'Airflow'

# Webserver
default['airflow']['config']['webserver']['base_url'] = 'http://localhost:8080'
default['airflow']['config']['webserver']['web_server_host'] = '0.0.0.0'
default['airflow']['config']['webserver']['web_server_port'] = 8080
default['airflow']['config']['webserver']['web_server_worker_timeout'] = 120
default['airflow']['config']['webserver']['secret_key'] = 'temporary_key'
default['airflow']['config']['webserver']['workers'] = 4
default['airflow']['config']['webserver']['worker_class'] = 'sync'
default['airflow']['config']['webserver']['expose_config'] = 'true'
default['airflow']['config']['webserver']['authenticate'] = 'true'
default['airflow']['config']['webserver']['auth_backend'] = 'airflow.contrib.auth.backends.ldap_auth'
default['airflow']['config']['webserver']['filter_by_owner'] = 'False'
default['airflow']['config']['webserver']['default_view'] = 'graph'

# Email
default['airflow']['config']['email']['email_backend'] = 'airflow.utils.email.send_email_smtp'

# SMTP
default['airflow']['config']['smtp']['smtp_host'] = 'localhost'
default['airflow']['config']['smtp']['smtp_starttls'] = 'False'
default['airflow']['config']['smtp']['smtp_ssl'] = 'False'
default['airflow']['config']['smtp']['smtp_port'] = 25
default['airflow']['config']['smtp']['smtp_mail_from'] = "#{node['airflow']['user']}\@#{node['fqdn']}"

# Celery
default['airflow']['config']['celery']['celeryd_concurrency'] = 5
default['airflow']['config']['celery']['celery_app_name'] = 'airflow.executors.celery_executor'
default['airflow']['config']['celery']['worker_log_server_port'] = 8793
default['airflow']['config']['celery']['broker_url'] = 'secret_word'
default['airflow']['config']['celery']['celery_result_backend'] = 'secret_word'
default['airflow']['config']['celery']['flower_port'] = 5555
default['airflow']['config']['celery']['default_queue'] = 'default'

# Scheduler
default['airflow']['config']['scheduler']['job_heartbeat_sec'] = 5
default['airflow']['config']['scheduler']['scheduler_heartbeat_sec'] = 5
default['airflow']['config']['scheduler']['max_threads'] = 2
default['airflow']['config']['scheduler']['catchup_by_default'] = 'True'

# LDAP
default['airflow']['config']['ldap']['uri'] = 'ldap://10.99.122.15:389'
default['airflow']['config']['ldap']['user_filter'] = 'objectClass=*'
default['airflow']['config']['ldap']['user_name_attr'] = 'uid'
default['airflow']['config']['ldap']['bind_user'] = nil
default['airflow']['config']['ldap']['bind_password'] = nil
default['airflow']['config']['ldap']['basedn'] = 'ou=People,dc=303net,dc=net'
default['airflow']['config']['ldap']['search_scope'] = 'BASE'
default['airflow']['config']['ldap']['cacert'] = nil

# Metrics
default['airflow']['config']['metrics']['reporter'] = 'LoggingReporter'
