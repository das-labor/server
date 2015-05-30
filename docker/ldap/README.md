OpenLDAP
========

This LDAP shall be used by all Labor services that need user authentication.

Schema
------

A Labor member is a single entry under `ou=users,dc=das-labor,dc=org` with
`objectClass` of `simpleSecurityObject` and `account` with additional `name`
and `mail` attributes.
Permissions are modelled using the entries under `cn=groups,dc=das-labor,dc=org`.
These need have an `objectClass` of `groupOfNames`.

Groups
------

* `editors`: Editor role on the Wordpress blog
* `admins`: Administrator role on the Wordpress blog
* `bureaucrat`: Bureaucrat role on the wiki.
