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
  - Puppet

Limitations
===========
  - Suse Linux isn't supported yet, but it should be easy to adapt it (pull requests are welcome)

How to use it
=============

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
