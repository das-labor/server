Installation of a server
========================

1. Install server through management interface with defaults (RAID1).

2. Set up initial user for yourself with sudo rights and ssh key.

3. Set up proper hostname (hostname, /etc/hostname, /etc/hosts).

4. apt-get update, apt-get upgrade, apt-get install language-pack-de

   Hetzner seems to install a base image with mixed locale setting,
   so install the de_DE.UTF-8 locale manually.

5. The rest is automatic:

   ansible$ ansible-playbook plays/site.yml
   

