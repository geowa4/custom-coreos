require 'spec_helper'

describe user('peripheral') do
  it { should exist }
  it { should have_home_directory '/home/peripheral' }
  it { should have_login_shell '/usr/bin/toolbox' }
end

describe file('/home/peripheral/.toolboxrc') do
  it { should exist }
  it { should be_file }
  its(:md5sum) { should eq '7a3af9d9d879c9b4ed5ac7e3adffb2a3' }
end
