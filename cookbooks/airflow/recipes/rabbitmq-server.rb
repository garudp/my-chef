secret = Chef::EncryptedDataBagItem.load_secret('/etc/chef/airflow-encrypted-data-bag-secret')
airflow_creds = Chef::EncryptedDataBagItem.load('airflow', node["airflow"]["databag_item"], secret)

rabbitmq_db_pass = airflow_creds["rabbitmq"] || Chef::Application.fatal!('Unable to find rabbitmq password in provided data bag')

yum_package 'rabbitmq-server' do
  action :install
end

service 'rabbitmq-server' do
  action [:enable, :start ]
end

execute 'add_rabbitmq_user' do
  command "rabbitmqctl add_user #{node["airflow"]["rabbitmq"]["db_user"]} #{rabbitmq_db_pass}"
  not_if "rabbitmqctl list_users | grep #{node["airflow"]["rabbitmq"]["db_user"]}"
end

execute 'add_rabbitmq_vhost' do
  command "rabbitmqctl add_vhost #{node["airflow"]["rabbitmq"]["db_user"]}_vhost"
  not_if "rabbitmqctl list_vhosts | grep #{node["airflow"]["rabbitmq"]["db_user"]}_vhost"
end

execute 'settag_rabbitmq_user' do
  command "rabbitmqctl set_user_tags #{node["airflow"]["rabbitmq"]["db_user"]}  #{node["airflow"]["rabbitmq"]["db_user_tag"]}"
  not_if "rabbitmqctl list_users | grep #{node["airflow"]["rabbitmq"]["db_user"]} | grep #{node["airflow"]["rabbitmq"]["db_user_tag"]}"
end

execute 'set_rabbitmq_permissions' do
  command "rabbitmqctl set_permissions -p #{node["airflow"]["rabbitmq"]["db_user"]}_vhost #{node["airflow"]["rabbitmq"]["db_user"]} \".*\" \".*\" \".*\""
  not_if "rabbitmqctl list_permissions -p #{node["airflow"]["rabbitmq"]["db_user"]}_vhost | grep -v vhost | grep #{node["airflow"]["rabbitmq"]["db_user"]}"
end
