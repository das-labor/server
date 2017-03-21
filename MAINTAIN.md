Maintenance
===========

Roles
-----

server: Basic configuration for new servers, mostly installs admin accounts and docker.

public: Public facing services like email, jabber, websites.

maintenance: Routine tasks. Reissues the self-signed TLS certificate.

Update
------

The docker containers are updated each time this runs:

ansible$ ansible-playbook plays/public.yml

The container should update if its configuration changes or the base
image is updated.

Note that site.yml includes this.


ETC
---

To update the mediawiki you have to do that via docker 
`docker exec -ti wiki maintenance/update.php`
