require 'spec_helper'

# Required by serverspec
set :backend, :exec

['/etc/supervisor.d',
].each do | directory |
  describe file(directory) do
    it { should be_directory }
	end
end


