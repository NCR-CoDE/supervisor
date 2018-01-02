#
# Cookbook Name:: supervisor
# Recipe:: compile_python 
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
if node['platform_version'].to_i < 7
  remote_file "/tmp/python-#{node['python']['fullver']}.tgz" do
    source node['python']['url'].to_s
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  log 'Building python'
  bash 'build_python' do
    user 'root'
    cwd '/tmp/'
    code <<-EOH
      yum -y install bzip2-devel
      tar xzvf "python-#{node['python']['fullver']}.tgz"
      cd "/tmp/Python-#{node['python']['fullver']}" i
      ./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
      make && make altinstall
    EOH
    not_if { ::File.exist?("#{node['python']['prefix_dir']}/bin/python#{node['python']['version']}") }
  end
end
