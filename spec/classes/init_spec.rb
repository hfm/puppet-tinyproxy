require 'spec_helper'
describe 'tinyproxy' do
  context 'with default values for all parameters' do
    it { should contain_class('tinyproxy') }
  end
end
