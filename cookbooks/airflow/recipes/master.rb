secret = Chef::EncryptedDataBagItem.load_secret('/etc/chef/airflow-encrypted-data-bag-secret')
airflow_creds = Chef::EncryptedDataBagItem.load('airflow', node["airflow"]["databag_item"], secret)

rabbitmq_db_pass = airflow_creds["rabbitmq"] || Chef::Application.fatal!('Unable to find rabbitmq password in provided data bag')
broker_url = "amqp://#{node["airflow"]["rabbitmq"]["db_user"]}:#{rabbitmq_db_pass}\@#{node["airflow"]["rabbitmq"]["db_host"]}:5672/#{node["airflow"]["rabbitmq"]["db_user"]}_vhost"

include_recipe "airflow::rabbitmq-server"
include_recipe "runit"


["scheduler", "webserver", "flower"].each do |srv|
    config = node["airflow"]["#{srv}_log_config"] || node["airflow"]["log_config"]

    runit_service "airflow-#{srv}" do
        options({'broker' => broker_url})
        log_dir node["airflow"]["#{srv}_log_path"]
        log_size config['size']
        log_num config['num']
        log_timeout config['age']
    end

end

template "/etc/cron.d/scheduler_logs" do
    source "scheduler_logs.erb"
    owner "root"
    group "root"
    mode 0644
end

template "/usr/local/bin/scheduler_logs_cleanup.sh" do
    source "scheduler_logs_cleanup.sh.erb"
    owner node["airflow"]["user"]
    group "root"
    mode 0754
end
