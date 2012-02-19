#
# Cookbook Name:: ./
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/httpd/conf.d/bark.conf" do
  source "bark.conf"
  mode "0644"
end

script "install_bark" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    rsync -avz --delete /vagrant/www/ /var/www/html/bark/
    chown apache.apache -R /var/www/html/bark
    chmod 777 -R /var/www/html/bark
    /etc/init.d/httpd restart
  EOH
end
