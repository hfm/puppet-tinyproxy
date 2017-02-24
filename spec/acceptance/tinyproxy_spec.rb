require 'spec_helper_acceptance'

describe 'tinyproxy class' do
  let(:manifest) do
    <<-EOS
      include ::tinyproxy
    EOS
  end

  it 'should work without errors' do
    expect(apply_manifest(manifest, catch_failures: true).exit_code).to eq 2
  end

  it 'should run a second time without changes' do
    expect(apply_manifest(manifest).exit_code).to be_zero
  end

  describe package('tinyproxy') do
    it { should be_installed }
  end

  describe service('tinyproxy') do
    it { should be_enabled }
    it { should be_running }
  end
end
