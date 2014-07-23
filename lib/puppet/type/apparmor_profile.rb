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
    newvalue(:enforced)

    newvalue(:complain)

    newvalue(:disabled)

    def retrieve
      provider.properties[:ensure]
    end
  end

  newparam(:source) do
    desc "Optional source of profile for File type, e.g. puppet:///modules/site/usr.bin.ping"
  end

  newparam(:template) do
    desc "Optional template for this profile, will be compiled with template()"
  end

  newparam(:template_vars) do
    desc "Optional hash of vars for the template compilation"
  end
  
end
