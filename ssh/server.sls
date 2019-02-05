install openssh server package:
  pkg.installed:
    - name: "openssh-server"

configure ssh service:
  file.managed:
    - name: /etc/systemd/system/sshd.service
    - source:
      - salt://ssh/files/sshd.service
    - user: root
    - group: root
    - mode: 0644
    - show_changes: true

configure sshd:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source:
      - salt://ssh/files/sshd_config
    - user: root
    - group: root
    - mode: 0644
    - show_changes: true

ensure sshd is running:
  service.running:
    - name: sshd.service
    - enable: true
    - watch:
      - file: /etc/ssh/sshd_config
    - require:
      - pkg: openssh-server