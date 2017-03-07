directory '/home/chef/.chef' do
  user 'chef'
  action :create
end

# ~/.chef/config.rb to be deployed via terraform per host

directory '/home/chef/cookbooks' do
  user 'chef'
  action :create
end

template '/home/chef/Berksfile' do
  source 'Berksfile.erb'
  user 'chef'
  action :create
end

execute 'berks vendor cookbooks' do
  user 'chef'
  environment({'BERKSHELF_PATH' => '/home/chef/.berkshelf'})
  cwd '/home/chef'
end

execute 'chown -R chef:chef /home/chef/cookbooks'

template '/usr/local/bin/run_chef' do
  source 'run_chef.erb'
  user 'root'
  group 'root'
  mode '0777'
  action :create
end
