#
# Cookbook Name:: rackspace_apt_test
# Recipe:: lwrps
#
# Copyright 2014, Rackspace, US Inc.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'rackspace_apt'

# Apt Repository
rackspace_apt_repository 'opscode' do
  uri 'http://apt.opscode.com'
  components ['main']
  distribution "#{node['lsb']['codename']}-0.10"
  key '2940ABA983EF826A'
  keyserver 'pgpkeys.mit.edu'
  action :add
end

# Apt Repository with arch
rackspace_apt_repository 'cloudera' do
  uri 'http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh'
  arch 'amd64'
  distribution 'precise-cdh4'
  components ['contrib']
  key 'http://archive.cloudera.com/debian/archive.key'
  action :add
end

# Apt repository and install a package it contains
rackspace_apt_repository 'nginx' do
  uri "http://nginx.org/packages/#{node['platform']}"
  distribution node['lsb']['codename']
  components ['nginx']
  key 'http://nginx.org/keys/nginx_signing.key'
  deb_src true
end

package 'nginx-debug' do
  action :upgrade
end

# Apt Preferences
rackspace_apt_preference 'chef' do
  pin 'version 10.16.2-1'
  pin_priority '700'
end

# COOK-2338
rackspace_apt_preference 'dotdeb' do
  glob '*'
  pin 'origin packages.dotdeb.org '
  pin_priority '700'
end
