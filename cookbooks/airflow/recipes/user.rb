airflow_user = node["airflow"]["user"]

user airflow_user do
  # This check is neeeded in the case, when the user already exists and its processes are running, ..
  # otherwise we will receive an erorr message "usermod: user myuser is currently logged in".
  # It works with LDAP accounts as well.
  # See: https://jira.integralads.com/browse/AUD-4673
  not_if { node['etc']['passwd'][airflow_user] }
  username airflow_user
  comment "Airflow user"
  home node["airflow"]["user_home_directory"]
  manage_home true
  shell node["airflow"]["shell"]
end

