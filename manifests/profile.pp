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

# Usage:
#
# apparmor::profile{"usr.bin.ping":
#   ensure        => enforce|complain|disabled|absent,
#   # optional parameters
#   source        => 'puppet:///modules/site_something/usr.bin.ping',
#   template      => 'site_something/usr.bin.ping.erb',
#   template_vars => { hash_structure },
# }
#
define apparmor::profile(
  $ensure          = undef,
  $source          = undef,
  $template        = undef,
  $template_params = undef,
){

  validate_re($ensure,['^enforce$','^complain$','^disabled$','^absent$'])

  #convert slashes in the name to the apparmor pointed name
  $aa_name = apparmor_normalize_name($name)
  notify{$aa_name:}

  if ($source) {
    file{"${$apparmor::params::profile_location}/${aa_name}":
      ensure => present,
      source => $source,
    }
  }elsif ($template) {
    file{"${$apparmor::params::profile_location}/${aa_name}":
      ensure  => present,
      content => template($template),
    }
  }

}
