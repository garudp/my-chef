# package 'apache2' do
#   case node['platform']
#   when 'centos', 'redhat', 'fedora', 'suse'
#       package_name 'httpd'
#   when 'debian', 'ubuntu'
#       package_name 'apache2'
#   end
#   action :install
# end

execute 'update-yum' do
  command "sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*"
  command "sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*"
end

package 'python-pip' do
  action :upgrade
end

# Install jira library
execute 'pip-install-jira' do
  command 'pip install jira'
end