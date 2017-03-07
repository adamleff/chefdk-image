directory '/home/chef/profiles/ssh/controls' do
  user 'chef'
  recursive true
  action :create
end

template '/home/chef/profiles/ssh/inspec.yml' do
  source 'inspec.yml.erb'
  user 'chef'
  action :create
end

template '/home/chef/profiles/ssh/controls/ssh.rb' do
  source 'ssh_control.erb'
  user 'chef'
  action :create
end

template '/home/chef/config.json' do
  source 'config.json.erb'
  user 'chef'
  action :create
end

execute 'chown -R chef:chef /home/chef/profiles'
