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
class apparmor (
  $package_ensure = $apparmor::params::package_ensure,
  $package_names  = $apparmor::params::package_names,
  $service_enable = $apparmor::params::service_enable,
  $service_ensure = $apparmor::params::service_ensure,
  $service_manage = $apparmor::params::service_manage,
  $service_name   = $apparmor::params::service_name,
) inherits apparmor::params {

  validate_array($package_names)
  validate_string($package_ensure)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)

  # puppet bug #8040, http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'apparmor::begin': } ->
  class { '::apparmor::install': } ->
  class { '::apparmor::service': } ->
  anchor { 'apparmor::end': }

}
