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
Puppet::Type.type(:apparmor_profile).provide(:apparmor_profile,
                                    :parent => Puppet::Provider
                                   ) do
  desc "This provider uses apparmor tools to configure apparmor profiles"

  commands :aa_enforce => "/usr/sbin/aa-enforce"
  commands :aa_complain => "/usr/sbin/aa-complain"
  commands :aa_status => "/usr/sbin/aa-status"
  commands :aa_disable => "/usr/sbin/aa-disable"

  @aa_disable_dir = "/etc/apparmor.d/disable"

  mk_resource_methods

  def self.instances
    profiles = []
    status = aa_status.split("\n")

    #do the enforced profiles
    enforced_start=status.index { |x| x =~ /profiles are in enforce mode/ } + 1
    enforced_length=status.index { |x| x =~ /profiles are in complain mode/ } - enforced_start
    status.slice(enforced_start,enforced_length).collect do |line|
      next if line !~ /\//
      line.strip!
      profiles << new(
        :name => line,
        :ensure => :enforced
     )
    end

    #do the complain profiles
    complain_start=status.index { |x| x =~ /profiles are in complain mode/ } + 1
    complain_length=status.index { |x| x =~ /processes have profiles defined/ } - complain_start
    status.slice(complain_start,complain_length).collect do |line|
      next if line !~ /\//
      line.strip!
      profiles << new(
        :name => line,
        :ensure => :complain
     )
    end

    #do the disabled profiles
    Dir.foreach(@aa_disable_dir) do |filename|
      next if filename=='.' or filename=='..'
      filename.gsub!(".","/")
      filename = "/#{filename}"
      profiles << new(
        :name => filename,
        :ensure => :disabled
     )
    end

    return profiles
  end

  #TBD
  def properties
    @property_hash
  end

  def enforce
    aa_enforce resource[:name]
  end

  def complain
    aa_complain resource[:name]
  end

  def disable
    aa_disable resource[:name]
  end

end
