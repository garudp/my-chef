include_recipe 'runit'

config = node['airflow']['worker_log_config'] || node['airflow']['log_config']

runit_service 'airflow-worker' do
  log_dir node['airflow']['worker_log_path']
  log_size config['size']
  log_num config['num']
  log_timeout config['age']
end

template '/etc/cron.daily/worker_logs_cleanup.sh' do
  source 'worker_logs_cleanup.sh.erb'
  owner 'root'
  group 'root'
  mode 0755
end
