# Labor Server

## Ansible

### Deploy on local Vagrant VM (VirtualBox)

Deploy local testing vm with:

    vagrant up
    ansible -i testing.ini server.yml

The vm will be reachable at `192.168.33.11`

SSH login via:

    vagrant ssh

Discard your vm with:

    vagrant destroy


#### Troubleshooting
If SSH connection fails you have to check `.ssh/known_hosts` and remove `[127.0.0.1]` or simply add the following lines to your **~/.ssh/config** to disable KeyChecking for connections to localhost.

```
Host 127.0.0.1
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
```
