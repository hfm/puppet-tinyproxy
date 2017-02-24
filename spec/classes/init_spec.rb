require 'spec_helper'
describe 'tinyproxy' do
  on_supported_os.each do |os, facts|
    context "with default values for all parameters on #{os}" do
      let(:facts) do
        facts
      end

      it { should compile }
      it { should contain_class('tinyproxy') }
    end
  end
end
