# Labor Server

## Ansible

### Deploy on local Vagrant VM (VirtualBox)

Deploy local testing vm with:

    vagrant up
    ansible -i testing.ini server.yml

Discard your VM with:

    vagrant destroy

If SSH connection fails you have to check `.ssh/known_hosts` and remove `[127.0.0.1]` 

The vm will be reachable at `192.168.33.11`
