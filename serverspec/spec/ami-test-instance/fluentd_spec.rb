require 'spec_helper'

describe service('fluentd') do
  it { should be_enabled }
  it { should be_running }
end

describe port(24_220) do
  it { should be_listening }
end

describe port(24_224) do
  it { should be_listening }
end
