Install borg backup from pip:
  pkg.installed:
    - pkgs:
      - python-pip
      - python3
      - python3-dev
      - python3-pip
      - python-virtualenv
      - libssl-dev
      - openssl
      - libacl1-dev
      - libacl1
      - build-essential
      - libfuse-dev
      - fuse
      - pkg-config
  pip.installed:
    - pkgs: ["borgbackup"]
    - bin_env: /usr/bin/pip3

Setup backup user:
  user.present:
    - name: backup
    - fullname: Backup User
    - home: /home/backup
    - shell: /bin/bash

Create backup users homedir mount:
  mount.mounted:
    - name: /home/backup
    - device: {{ pillar['backup_mount']['device'] }}
    - fstype: {{ pillar['backup_mount']['fs'] }}
    - opts: {{ pillar['backup_mount']['opts'] }}
    - persist: True
    - mount: True
    - require:
      - user: backup

{% for host, key in pillar['backup_clients'].items() %}
Give backup access to {{host}}:
  ssh_auth.present:
    - user: backup
    - name: {{ key }}
    - options:
      - command="cd /home/backup/repos/{{host}}; borg serve --restrict-to-path /home/backup/repos/{{host}}"
      - restrict

Create Repo dir for {{ host }}:
  file.directory:
    - name: /home/backup/repos/{{host}}
    - user: backup
    - group: backup
    - makedirs: true
    - mode: 700
    - recursive:
      - user
      - group
      - mode
{% endfor %}
