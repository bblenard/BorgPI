# authorized_keys is a hash that has usernames as keys that map to a list
# of public ssh keys that should appear in the users authorized_keys file
# this can be used to setup admin users for normal ssh logins
authorized_keys:
  username:
    - "public ssh key"
