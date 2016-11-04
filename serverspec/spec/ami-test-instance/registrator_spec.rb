require 'spec_helper'

describe service('etcd-registrator') do
  it { should be_enabled }
  it { should be_running }
end
