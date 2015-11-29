Labor Frontend Server
=====================

This nginx serves as a reverse proxy and TLS termination point for all websites
on Bandit. If you want to serve HTTP content add the name of your Docker image
to `revproxy.conf` and link your image to `lfe`. Please update this README
after doing so.


[TLS termination](http://www.zdnet.com/article/google-the-nsa-and-the-need-for-locking-down-datacenter-traffic/) is done for blog and wiki.

Linked Images
-------------

| Image Name    | Server Name                                                              |
| ------------- | ------------------------------------------------------------------------ |
| `blog`        | `www.das-labor.org`, `das-labor.org`, `blog.das-labor.org`               |
| `wiki`        | `wiki.das-labor.org`                                                     |
| `static-web`  | `lt15.das-labor.org`, `repaircafe-bochum.de`, `www.repaircafe-bochum.de` |
| `meet`        | `meet.das-labor.sexy`                                                    |
| `safe`        | Volume Container for the TL certificate                                  |
