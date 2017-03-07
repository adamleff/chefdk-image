template '/etc/ssh/sshd_config' do
  source 'sshd_config.erb'
  action :create
end
