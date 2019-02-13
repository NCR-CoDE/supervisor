#
# Author:: Seth Chisamore <schisamo@chef.io>
# Cookbook Name:: supervisor
# Resource:: pip
#
# Copyright:: 2011, Chef Software, Inc <legal@chef.io>
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

resource_name :supervisor_pip

property :package_name, String, name_property: true
property :version, String, default: 'latest'
property :timeout, Integer, default: 900
property :virtualenv, String
property :user, regex: Chef::Config[:user_valid_regex]
property :group, regex: Chef::Config[:group_valid_regex]
property :options, String, default: ''
property :environment, Hash, default: {}

default_action :install

action :install do
  pip_cmd('install', new_resource)
end

def pip_cmd(subcommand, new_resource)
  options = { :timeout => new_resource.timeout, :user => new_resource.user, :group => new_resource.group }
  version = ''

  if (new_resource.version != 'latest') && (new_resource.version != '')
    version = "==#{new_resource.version}"
  end

  environment = Hash.new

  if new_resource.user
    environment['HOME'] = Dir.home(new_resource.user)
  end

  if new_resource.environment && !new_resource.environment.empty?
    environment.merge!(new_resource.environment)
  end

  options[:environment] = environment
  
  if !subcommand.nil? && !subcommand.empty?
    cmd = "#{node['python']['pip_location']} #{subcommand} #{new_resource.options} #{new_resource.package_name}#{version}"
    Chef::Log.error("Running cmd: #{cmd}")
    shell_out(cmd, options)
  end
end

