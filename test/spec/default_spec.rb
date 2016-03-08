
require_relative 'spec_helper'

describe 'chef_workstation' do
  let(:chef_run) { ChefSpec::SoloRunner.new(RUNNER_OPTS) }

  before :each do
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('/usr/local/workstation_setup').and_return(false)
  end

  it 'should include chef-dk recipe' do
    chef_run.converge described_recipe
    expect(chef_run).to include_recipe 'chef-dk'
  end

  it 'should include python recipe' do
    chef_run.converge described_recipe
    expect(chef_run).to include_recipe 'python'
  end

  it 'should include awscli recipe' do
    chef_run.converge described_recipe
    expect(chef_run).to include_recipe 'awscli'
  end

  it 'should execute command to install nokogiri' do
    chef_run.converge described_recipe
    expect(chef_run).to run_execute 'install nokogiri'
  end

  it 'should install packages' do
    chef_run.converge described_recipe
    expect(chef_run).to install_yum_package 'gcc'
    expect(chef_run).to install_yum_package 'make'
    expect(chef_run).to install_yum_package 'automake'
    expect(chef_run).to install_yum_package 'autoconf'
    expect(chef_run).to install_yum_package 'curl-devel'
    expect(chef_run).to install_yum_package 'openssl-devel'
    expect(chef_run).to install_yum_package 'zlib-devel'
    expect(chef_run).to install_yum_package 'libxml2'
    expect(chef_run).to install_yum_package 'libxml2-devel'
    expect(chef_run).to install_yum_package 'git'
    expect(chef_run).to install_yum_package 'jq'
  end

  it 'should do nothing for file workstation_configured' do
    chef_run.converge described_recipe
    expect(chef_run).not_to create_file '/usr/local/workstation_configured'
  end

  it 'set ruby path for all uses' do
    chef_run.converge described_recipe
    expect(chef_run).to create_template '/etc/profile.d/workstation_setup.sh'
  end
end
# vim: ai et ts=2 sts=2 sw=2 ft=ruby
