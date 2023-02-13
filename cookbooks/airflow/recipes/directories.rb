dir_airflow_tree = [node['airflow']['config']['core']['airflow_home'], node['airflow']['config']['core']['plugins_folder'], node['airflow']['config']['core']['base_log_folder'], node['airflow']['run_path'], node['airflow']['pid_path'], node['airflow']['flags_dir']]

dir_airflow_tree.each do |path|
  directory path do
    owner node['airflow']['user']
    group node['airflow']['group']
    mode node['airflow']['directories_mode']
    action :create
    recursive true
  end
end

dir_airflow_dags = [node['airflow']['config']['core']['dags_folder'], node['airflow']['config']['core']['dags_archive_folder']]

dir_airflow_dags.each do |path|
  directory path do
    owner node['airflow']['deploy_user']
    group node['airflow']['deploy_group']
    mode 0755
    action :create
    recursive true
  end
end

dir_log_tree = [node['airflow']['log_path'], node['airflow']['scheduler_log_path'], node['airflow']['worker_log_path'], node['airflow']['webserver_log_path'], node['airflow']['flower_log_path']]

dir_log_tree.each do |path|
  directory path do
    owner 'logger'
    group 'logger'
    mode '0755'
    action :create
    recursive true
  end
end
