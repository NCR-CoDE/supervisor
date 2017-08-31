# encoding: utf-8

require 'bundler'
require 'bundler/setup'
require 'berkshelf/thor'
require 'chef/cookbook/metadata'

METADATA_FILE = "metadata.rb"

# This should be changed to a thor library at some point
class NCR < Thor
  package_name "NCR"
  include Thor::Actions

  desc "release", "Increament the version and create a branch" 
  def release
    local_mods = run("git status --porcelain", :capture => true).chomp
    if (local_mods != "")
      say "cannot release with local modifications"
      say local_mods
      return
    end

    metadata = Chef::Cookbook::Metadata.new
    metadata.from_file(METADATA_FILE)
    new_version = "v#{metadata.version}"
    listed_version = run("git tag -l #{new_version}", :capture => true).chomp

    if (listed_version == new_version)
      say "Tag #{new_version} already exists, update the version in #{METADATA_FILE} to do a release"
      return
    else
      say "doing a release"
      run "git commit -am 'doing a release'"
      run "git tag -a v#{metadata.version} -m 'a new release'"
      run "git push"
      run "git push --tags"
    end
  end

end

begin
  require 'kitchen/thor_tasks'
  Kitchen::ThorTasks.new
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end
