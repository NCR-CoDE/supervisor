require 'spec_helper'

# Required by serverspec
set :backend, :exec

describe "Ssh Daemon" do

  it "is listening on port 22" do
    expect(port(22)).to be_listening
  end

  it "has a running service of ssh-daemon" do
    expect(service("sshd")).to be_running
  end

end
