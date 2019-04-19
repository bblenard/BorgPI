# BorgPI: Salt PI backup server

# Variables
---

## Pillar

### pillar/ssh.sls
```yaml
# authorized_keys is a hash that has usernames as keys that map to a list
# of public ssh keys that should appear in the users authorized_keys file
authorized_keys:
  username:
    - "public ssh key"
```

### pillar/borg.sls
```yaml
# backup_clients are the hosts that will be allowed to backup to the PI backup
# server. backup_clients is a hash that maps hostnames to sshkeys. The ssh keys
# will be added to the backup user and hosts that own that sshkey will be able
# to set their BORG_REPO=backup@YOUR_BACKUP_SERVER:./ and begin using the remote
# borg server
backup_clients:
  hostname: "public ssh key"

# backup_mount is a hash that configures the backup server storage you can pass
# device, fs type, and mount options to the PI os.
backup_mount:
  device: "UUID=aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
  fs: "ext4"
  mount_opts: "defaults"
```
