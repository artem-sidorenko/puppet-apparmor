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

describe 'apparmor::params' do

  context 'os family debian' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}
    it do
      should compile.with_all_deps
    end
  end

  context 'not supported osfamily' do
    let(:facts) {{
      :osfamily => 'someunsupported',
    }}
    it do
      expect {
        should compile
      }.to raise_error(Puppet::Error, /Unsupported osfamily \(someunsupported\)/)
    end
  end

end
