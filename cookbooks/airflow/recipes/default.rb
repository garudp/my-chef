secret = Chef::EncryptedDataBagItem.load_secret( node["airflow"]["databag_secret_key"] )
airflow_creds = Chef::EncryptedDataBagItem.load('airflow', node["airflow"]["databag_item"], secret)

params = node["airflow"].to_hash

params["db_pass"] = airflow_creds["airflow"] || Chef::Application.fatal!('Unable to find airflow password in provided data bag')
params["celery"]["db_pass"] = airflow_creds["celery"] || Chef::Application.fatal!('Unable to find celery password in provided data bag')
params["rabbitmq"]["db_pass"] = airflow_creds["rabbitmq"] || Chef::Application.fatal!('Unable to find rabbitmq password in provided data bag')
params["config"]["core"]["fernet_key"] = airflow_creds["fernet_key"] || Chef::Application.fatal!('Unable to find fernet_key key in provided data bag')

params["config"]["core"]["sql_alchemy_conn"] = "postgresql://#{params["db_user"]}:#{params["db_pass"]}@#{params["db_host"]}:#{params["db_port"]}/#{params["db_name"]}"
params["config"]["celery"]["broker_url"] = "amqp://#{params["rabbitmq"]["db_user"]}:#{params["rabbitmq"]["db_pass"]}\@#{params["rabbitmq"]["db_host"]}:#{params["celery"]["broker_port"]}/#{params["rabbitmq"]["db_user"]}_vhost"
params["config"]["celery"]["celery_result_backend"] = "db+postgresql://#{params["celery"]["db_user"]}:#{params["celery"]["db_pass"]}@#{params["celery"]["db_host"]}:#{params["celery"]["db_port"]}/#{params["celery"]["db_name"]}"
params["config"]["metrics"]["tags"] = "host:#{node["fqdn"]}, env:#{node["airflow"]["metrics"]["env"]}"

include_recipe "airflow::user"
include_recipe "airflow::directories"

template "#{params["config"]["core"]["airflow_home"]}/airflow.cfg" do
  source "airflow.cfg.erb"
  owner params["user"]
  group params["group"]
  mode params["config_file_mode"]
  variables({
      :config => params["config"]
  })
end

template "airflow_services_env" do
  source "airflow-env.erb"
  path "/etc/sysconfig/airflow"
  owner "root"
  group "root"
  mode "0644"
  variables({
    :platform => node[:platform],
    :config => params["config"]
  })
end

template "#{node["airflow"]["bin_path"]}/airflow_local_settings.py" do
  source "airflow_local_settings.py.erb"
  owner "root"
  group "root"
  mode "0644"
  only_if { node["airflow"]["use_airflow_local_settings"] }
end

