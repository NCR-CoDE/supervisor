require 'spec_helper'

# Required by serverspec
set :backend, :exec

describe "Supervisor service" do

  it "has a running service of supervisor" do
    expect(service("supervisor")).to be_running
  end

end
