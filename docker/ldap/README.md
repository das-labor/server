OpenLDAP
========

This LDAP shall be used by all Labor services that need user authentication.

Schema
------

A Labor member is a single entry under `cn=users,dc=das-labor,dc=org` with
`objectClass` of `simpleSecurityObject and `inetOrgPerson`. Permissions of a
user are modeled using the entries under `cn=groups,dc=das-labor,dc=org`.
These need have an `objectClass` of `groupOfNames`.
