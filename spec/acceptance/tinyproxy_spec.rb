require 'spec_helper_acceptance'

describe 'tinyproxy class' do
  let(:manifest) do
    <<-EOS
      class { 'tinyproxy':
        default_upstreams => ['internal.example.com:80'],
        upstreams    => {
          'testproxy:8008' => ['.test.domain.invalid', '192.168.128.0/255.255.254.0'],
        },
        no_upstreams => ['www.example.com'],
        add_headers => {
          'X-My-Header' => 'Powored by Tinyproxy',
        },
        reverse_paths => {
          '/google/' => 'http://www.google.com/',
          '/wired/' => 'http://www.wired.com/',
        },
      }
    EOS
  end

  it 'should work without errors' do
    expect(apply_manifest(manifest, catch_failures: true).exit_code).to eq 2
  end

  it 'should run a second time without changes' do
    expect(apply_manifest(manifest).exit_code).to be_zero
  end

  describe yumrepo('epel'), if: os[:family] == 'redhat' do
    it { should be_enabled }
  end

  describe package('tinyproxy') do
    it { should be_installed }
  end

  config_path = case os[:family]
                when 'redhat' then '/etc/tinyproxy/tinyproxy.conf'
                when 'debian' then '/etc/tinyproxy/tinyproxy.conf'
                when 'ubuntu' then '/etc/tinyproxy.conf'
                end

  user = case os[:family]
         when 'redhat' then 'tinyproxy'
         when 'debian' then 'tinyproxy'
         when 'ubuntu' then 'nobody'
         end

  group = case os[:family]
          when 'redhat' then 'tinyproxy'
          when 'debian' then 'tinyproxy'
          when 'ubuntu' then 'nogroup'
          end

  describe file(config_path) do
    it { should be_file }
    its(:content) { should match /^User\s+#{user}$/ }
    its(:content) { should match /^Group\s+#{group}$/ }
    its(:content) { should match /^Timeout\s+\d+$/ }
    its(:content) { should match /^LogLevel\s+Info$/ }
    its(:content) { should match /^upstream\s+internal.example.com:80$/ }
    its(:content) { should match /^upstream\s+testproxy:8008 ".test.domain.invalid"$/ }
    its(:content) { should match /^upstream\s+testproxy:8008 "192.168.128.0\/255.255.254.0"$/ }
    its(:content) { should match /^no upstream\s+"www.example.com"$/ }
    its(:content) { should match /^MaxClients\s+\d+/ }
    its(:content) { should match /^MinSpareServers\s+\d+$/ }
    its(:content) { should match /^MaxSpareServers\s+\d+$/ }
    its(:content) { should match /^StartServers\s+\d+$/ }
    its(:content) { should match /^MaxRequestsPerChild\s+\d+$/ }
    its(:content) { should match /^Allow\s+127\.0\.0\.1$/ }
    its(:content) { should match /^AddHeader\s+"X-My-Header" "Powored by Tinyproxy"$/ }
    its(:content) { should match /^DisableViaHeader\s+No$/ }
    its(:content) { should match /^ConnectPort\s+443$/ }
    its(:content) { should match /^ConnectPort\s+563$/ }
    its(:content) { should match %r{^ReversePath\s+"/google/" "http://www.google.com/"$} }
    its(:content) { should match %r{^ReversePath\s+"/wired/" "http://www.wired.com/"$} }
  end

  describe service('tinyproxy') do
    it { should be_enabled }
    it { should be_running }
  end

  describe process('tinyproxy') do
    it { should be_running }
    its(:user) { should eq user }
  end

  describe port(8888) do
    it { should be_listening.on('0.0.0.0').with('tcp') }
  end
end
