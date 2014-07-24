#
# apparmor puppet module
# https://github.com/artem-sidorenko/puppet-apparmor
#
# Author Artem Sidorenko artem@2realities.com
#
# Copyright 2014 Artem Sidorenko and contributors.
# Copyright 2014 Deutsche Telekom AG
# See the COPYRIGHT file at the top-level directory of this distribution
# and at https://github.com/artem-sidorenko/puppet-apparmor/blob/master/COPYRIGHT
#
require 'spec_helper'

describe 'apparmor' do

  let(:facts) {{
        :osfamily => 'Debian',
  }}

  it { should contain_class('apparmor::install') }
  it { should contain_class('apparmor::service') }

  describe "apparmor::service" do
    context 'service_ensure wrong value' do
      let(:params) { {:service_ensure => 'unsupported'} }
      it do
        expect {
          should compile
        }.to raise_error(Puppet::Error, /service_ensure parameter must be running or stopped/)
      end
    end

    describe 'service_ensure correct value' do
      ['running','stopped'].each do |state|
        context "service_ensure #{state}" do
          let(:params) {{
            :service_ensure => state,
          }}
          it do
            should contain_service('apparmor').with({
              'ensure' => state,
            })
          end
        end
      end
    end

  end

end
