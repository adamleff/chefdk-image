execute "yum update -y"

chef_ingredient 'chefdk' do
  action :install
  channel :stable
end

include_recipe "#{cookbook_name}::centos-chef_user"

include_recipe "#{cookbook_name}::centos_sshd_config"

needed_packages_for_attendees = %w[ vim nano emacs git tree ]
package needed_packages_for_attendees

include_recipe "#{cookbook_name}::centos-docker"

include_recipe "#{cookbook_name}::centos-permissions"

include_recipe "#{cookbook_name}::centos-ec2_hints"

include_recipe "#{cookbook_name}::compliance_cookbooks"

template '/home/chef/config.json' do
  source 'config-nyc-meetup.json.erb'
  user 'chef'
  action :create
end

remote_file '/tmp/habitat.tar.gz' do
  source 'https://api.bintray.com/content/habitat/stable/linux/x86_64/hab-%24latest-x86_64-linux.tar.gz?bt_package=hab-x86_64-linux'
  action :create
end

execute 'tar -xzvf habitat.tar.gz' do
  cwd '/tmp/'
end

ruby_block 'move habitat into path' do
  block do
    FileUtils.cp_r('/tmp/hab-0.20.0-20170407021836-x86_64-linux/hab', '/usr/bin/hab')
  end
end

group 'hab'
user 'hab' do
  group 'hab'
end
