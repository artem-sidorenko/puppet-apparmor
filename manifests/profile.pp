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

  include apparmor

  validate_re($ensure,['^enforced$','^complain$','^disabled$','^absent$'])

  #convert slashes in the name to the apparmor pointed name
  $aa_name = apparmor_normalize_name($name)
  $aa_profile_path = "${$apparmor::params::profile_location}/${aa_name}"

  if ($ensure == 'absent') {
    file{$aa_profile_path:
      ensure => absent,
    }
  }elsif ($source) {
    file{$aa_profile_path:
      ensure => present,
      source => $source,
    }
  }elsif ($template) {
    file{$aa_profile_path:
      ensure  => present,
      content => template($template),
    }
  }

  apparmor_profile{$name:
    ensure => $ensure,
  }

}
