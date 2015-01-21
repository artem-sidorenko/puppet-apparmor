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
Puppet::Type.newtype(:apparmor_profile) do

  @doc = "Manages AppArmor profiles."

  newparam(:name, :namevar => true) do
    desc "Name of the apparmor profile"
    isnamevar
  end

  ensurable do
    newvalue(:enforced) do
      provider.enforce
    end

    newvalue(:complain) do
      provider.complain
    end

    newvalue(:disabled) do
      provider.disable
    end

    #disable absent profiles
    newvalue(:absent) do
      provider.disable
    end

    def retrieve
      provider.properties[:ensure]
    end
  end

end
