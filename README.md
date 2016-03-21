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


Ports
-----

The role "public" is served by "bandit".  This table shows the
allocated ports:

* 0.0.0.0:22: Reserved for SSH.
* 0.0.0.0:25: Reserved for SMTP.
* 0.0.0.0:53: Reserved for DNS.
* 0.0.0.0:80: lfe (HTTP)
* 0.0.0.0:143: Reserved for IMAP.
* 0.0.0.0:443: lfe (HTTPS)
* 0.0.0.0:587: SMTP Message Submission
* 0.0.0.0:993: Reserved for IMAPS.(deprecated as port 465?)
* 0.0.0.0:1812: Reserved for RADIUS (for Spacenet WLAN Roaming)
* 0.0.0.0:1814: Reserved for RADIUS (for Spacenet WLAN Roaming)
* 0.0.0.0:4190: Sieve
* 0.0.0.0:10000/udp: meet SRTP (Jitsi)
* 0.0.0.0:10001/udp: meet SRTP (Jitsi)
* 0.0.0.0:10002/udp: meet SRTP (Jitsi)
* 0.0.0.0:10003/udp: meet SRTP (Jitsi)
* 0.0.0.0:10004/udp: meet SRTP (Jitsi)
* 0.0.0.0:10005/udp: meet SRTP (Jitsi)
* 0.0.0.0:10006/udp: meet SRTP (Jitsi)
* 0.0.0.0:10007/udp: meet SRTP (Jitsi)
* 0.0.0.0:10008/udp: meet SRTP (Jitsi)
* 0.0.0.0:10009/udp: meet SRTP (Jitsi)
* 0.0.0.0:10010/udp: meet SRTP (Jitsi)
* 0.0.0.0:5222: Reserved for XMPP-CLIENT.
* 0.0.0.0:5269: Reserved for XMPP-SERVER.
* 0.0.0.0:5280: Reserved for XMPP-BOS.H
