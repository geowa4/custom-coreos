require 'spec_helper'

describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end

describe file(
  '/etc/systemd/system/docker.service.d/10-docker-requires-flannel.conf'
) do
  it { should exist }
  it { should be_file }
  its(:md5sum) { should eq 'c9e26bef60a93f2b804020dc3a9356e1' }
end
