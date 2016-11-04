require 'spec_helper'

describe service('flanneld') do
  it { should be_enabled }
  it { should be_running }
end

describe file(
  '/etc/systemd/system/flanneld.service.d/50-network-config.conf'
) do
  it { should exist }
  it { should be_file }
  its(:md5sum) { should eq 'f8d50975434469567ae8baea71b48d16' }
end
