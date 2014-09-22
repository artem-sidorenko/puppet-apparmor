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

#
# apparmor_normalize_name(name)
#
# Function takes the name as a path (e.g. /usr/bin/ping) and converts it
# to the apparmor valid profile name (e.g. usr.bin.ping)
#
# This function is usefull for deployment of new or custom profiles
#
module Puppet::Parser::Functions
  newfunction(:apparmor_normalize_name, :type => :rvalue, :doc => <<-EOS
Converts the path to the apparmor profile name
  EOS
  ) do |args|

    raise(Puppet::ParseError, "apparmor_normalize_name(): wrong number of arguments " +
"given (#{args.size} for 1)") if args.size != 1

    path = args[0]

    raise(Puppet::ParseError, "apparmor_normalize_name(): first argument should be a string") if !path.is_a?(String)

    profile_name = path.gsub(/^\//,"")
    profile_name.gsub!("/",".")

    return profile_name

  end
end
