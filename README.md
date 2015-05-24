Labor e.V. Server
=================

If you want to install a service on the server, make a pull request
and the admins will review it.

If you find a bug, please report it here.

Setup
-----

* All services are docker containers.
* All data volumes go to /srv/docker (this is the main backup folder)
* The host system is fully configured with ansible, see [INSTALL](INSTALL.md) and [MAINTAIN](MAINTAIN.md)


Public Ports
------------

The role "public" is served by "bandit".  This table shows the
allocated ports:

* 20080: elektropott.de
