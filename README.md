puppet-apparmor
===============
Puppet module to manage apparmor profiles.

**IN PROGRESS, UNSTABLE**

[![Build Status](https://travis-ci.org/artem-sidorenko/puppet-apparmor.svg?branch=master)](https://travis-ci.org/artem-sidorenko/puppet-apparmor)

* [Introduction](#introduction)
* [Features](#features)
* [Requirements](#requirements)
* [Limitations](#limitations)
* [How to use it](#how-to-use-it)
* [Contributing](#contributing)
* [License and copyright](#license-and-copyright)

Introduction
============
This puppet module allows management of [AppArmor](https://en.wikipedia.org/wiki/AppArmor) profiles. Apparmor is an implementation of [Mandatory Access Control](https://en.wikipedia.org/wiki/Mandatory_access_control) model (similar to [Selinux](https://en.wikipedia.org/wiki/Security-Enhanced_Linux)) used in Ubuntu and Suse for the isolation of applications running on the same host.

Features
========
  - Different apparmor modes are supported (enforced, complain, disabled)
  - Apparmor modes can be switched for the existing apparmor profiles (e.g. shipped with OS)
  - Custom apparmor profiles can be installed
  - Custom apparmor profiles may contain parametes expanded via puppet variables (might be usefull if you want to use this module from another puppet module, which installes and configures something)

Requirements
============
  - Ubuntu Linux
    - Tested on 12.04 and 14.04
  - Puppet >2.7.x (tested on puppet 2.7.11)

Limitations
===========
  - Suse Linux isn't supported yet, but it should be easy to adapt it (pull requests are welcome)
  - Template functionality isn't fully implemented yet

Structure
=========
  This module uses both module types of puppet: native ruby type/provider and puppet DSL module:

  - Native ruby type `apparmor_profile` is used for apparmor runtime configuration/control and ideally shouldn't be invoked directly
  - `apparmor::*` is a puppet DSL module, where `apparmor::profile` builds an overlay over the native module an extends the functionality with templates file management of profiles

Folder structure:

  - `lib/` - native ruby type and provider, incl helper functions
  - `manifests/` - puppet DSL code
    - `init.pp` - `apparmor` initialization class, ensures the installation and service configuration of apparmor. Included by other classes/types
    - `install.pp` - `apparmor::install` class, installs apparmor packages
    - `params.pp` - `apparmor::params` class, some global defaults reused in other classes
    - `profile.pp` - `apparmor::profile` type, main entry point for managing apparmor profiles
    - `service.pp` - `apparmor::service` class, controlls the apparmor service
  - `spec/` - puppet unit tests
  - `.travis.yml`, `Rakefile`, `.gemfile`, `.fixtures.yml` - used for travis CI tests


How to use it
=============

Controlling an existing default profile

```puppet
apparmor::profile{"/sbin/dhclient":
  #possible options: enforced, complain, disabled, absent
  ensure => enforced,
}
```

Rolling out a new profile without parameters

```puppet
apparmor::profile{"/sbin/dhclient":
  ensure => enforced,
  source => 'puppet:///modules/site_something/sbin.dhclient',
}
```

Rolling out a new profile with parameters

```puppet
apparmor::profile{"/sbin/dhclient":
  ensure   => enforced,
  template => 'site_something/sbin.dhclient.erb',
  template_vars => { hash_structure TBD },
}
```

Contributing
============

Please use [GitHub Pull requests][github_pullreq] for this.


License and copyright
=====================
Copyright 2014-2015 Artem Sidorenko and contributors.

Copyright 2014 Deutsche Telekom AG

See the COPYRIGHT file at the top-level directory of this distribution
and at https://github.com/artem-sidorenko/puppet-apparmor/blob/master/COPYRIGHT

[github_pullreq]: https://help.github.com/articles/using-pull-request
