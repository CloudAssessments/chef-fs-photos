#
# Cookbook:: bootstrap
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'sshd::default'

service 'sshd' do
  action :stop
end

package 'git'

if node['platform_family'] == "debian"

  user 'cloud_user' do
    home '/home/cloud_user'
    manage_home true
    shell '/bin/bash'
    password '$1$linuxaca$iGMxZ4g4lbPmfEDPhW3lw1'
    salt 'linuxacademy'
  end

  openssh_server '/etc/ssh/sshd_config' do
    PasswordAuthentication yes
  end
end

if node['platform_family'] == "rhel"
  package 'docker'

  service 'docker' do
    action :start
  end
end

git '/home/cloud_user/fs-photos' do
  repository 'https://github.com/CloudAssessments/fs-photos.git'
  action :sync
  user 'cloud_user'
  group 'cloud_user'
end

execute 'install photo-filter' do
  command 'touch /home/cloud_user/fs-photos/system-secrets'
end

service 'sshd' do
  action :start
end
