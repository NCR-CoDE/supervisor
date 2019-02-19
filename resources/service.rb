#
# Author:: Noah Kantrowitz <noah@opscode.com>
# Cookbook Name:: supervisor
# Resource:: service
#
# Copyright:: 2011, Opscode, Inc <legal@opscode.com>
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

resource_name :supervisor_service

default_action :enable

property :service_name, String, name_property: true
property :command, String
property :process_name, String, default: '%(program_name)s'
property :numprocs, Integer, default: 1
property :numprocs_start, Integer, default: 0
property :priority, Integer, default: 999
property :autostart, [TrueClass, FalseClass], default: true
property :autorestart, [String, Symbol, TrueClass, FalseClass], default: :unexpected
property :startsecs, Integer, default: 1
property :startretries, Integer, default: 3
property :exitcodes, Array, default: [0, 2]
property :stopsignal, [String, Symbol], default: :TERM
property :stopwaitsecs, Integer, default: 10
property :stopasgroup, [TrueClass,FalseClass], default: nil
property :killasgroup, [TrueClass,FalseClass], default: nil
property :user, [String, NilClass], default: nil
property :redirect_stderr, [TrueClass, FalseClass], default: false
property :stdout_logfile, String, default: 'AUTO'
property :stdout_logfile_maxbytes, String, default: '50MB'
property :stdout_logfile_backups, Integer, default: 10
property :stdout_capture_maxbytes, String, default: 0
property :stdout_events_enabled, [TrueClass, FalseClass], default: false
property :stderr_logfile, String, default: 'AUTO'
property :stderr_logfile_maxbytes, String, default: '50MB'
property :stderr_logfile_backups, Integer, default: 10
property :stderr_capture_maxbytes, String, default: '0'
property :stderr_events_enabled, [TrueClass, FalseClass], default: false
property :environment, Hash, default: {}
property :directory, [String, NilClass], default: nil 
property :umask, [NilClass, String], default: nil
property :serverurl, String, default: 'AUTO'

property :eventlistener, [TrueClass,FalseClass], default: false
property :eventlistener_buffer_size, Integer, default: nil
property :eventlistener_events, Array, default: nil

