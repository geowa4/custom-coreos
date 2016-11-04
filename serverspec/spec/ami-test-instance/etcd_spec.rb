require 'spec_helper'

describe service('etcd2') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/systemd/system/etcd2.service.d/20-proxy.conf') do
  it { should exist }
  it { should be_file }
  its(:md5sum) { should eq 'fa1ca1aade71d4599964bbc211e382dd' }
end

describe port(2379) do
  it { should be_listening }
end
