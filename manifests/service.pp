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
class apparmor::service inherits apparmor
{
  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    service { 'apparmor':
      ensure => $service_ensure,
      enable => $service_enable,
      name   => $service_name,
    }
  }
}
