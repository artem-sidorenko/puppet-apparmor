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

describe 'apparmor_normalize_name' do

  context 'input as a path /usr/bin/ping' do
    it do
       should run.with_params('/usr/bin/ping').and_return('usr.bin.ping')
    end
  end

  context 'input as an apparmor name usr.bin.ping' do
    it do
      should run.with_params('usr.bin.ping').and_return('usr.bin.ping')
    end
  end

end
