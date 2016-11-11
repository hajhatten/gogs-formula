{% from "gogs/map.jinja" import gogs with context %}
{% set config = gogs.config %}
{% set repo = gogs.repository %}

git:
  pkg.installed

gogs_archive:
  archive.extracted:
    - name: {{ config['extract_archive_dir'] }}
    - source: https://github.com/gogits/gogs/releases/download/{{ config['version'] }}/linux_amd64.tar.gz
    - source_hash: {{ config['hash_type'] }}={{ config['hash'] }}
    - archive_format: tar
    - user: {{ config['run_user'] }}
    - group: {{ config['run_user'] }}
    - if_missing: {{ config['install_dir'] }}/gogs
    - require:
      - user: gogs

{{ config['install_dir'] }}:
  file.directory:
    - user: {{ config['run_user'] }}
    - group: {{ config['run_user'] }}
    - mode: 755
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: gogs

config_file:
  file.managed:
    - name: {{ config['install_dir'] }}/custom/conf/app.ini
    - source: salt://gogs/files/app.ini
    - user: {{ config['run_user'] }}
    - group: {{ config['run_user'] }}
    - mode: 755
    - makedirs: True
    - template: jinja
    - require:
      - user: gogs

repo_dir:
  file.directory:
    - name: {{ repo['repository_path'] }}
    - user: {{ config['run_user'] }}
    - group: {{ config['run_user'] }}
    - mode: 755
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: gogs
  
log_dir:
  file.directory:
    - name: {{ config['log_dir'] }}
    - user: {{ config['run_user'] }}
    - group: {{ config['run_user'] }}
    - mode: 755
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: gogs

{{ config['log_dir'] }}/gogs.log:
  file.touch

/etc/systemd/system/gogs.service:
  file.managed:
    - source: salt://gogs/files/gogs.service
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - require:
      - archive: gogs_archive

gogs:
  user.present: []
  service.running:
    - enable: True
    - requires:
      - pkg: git
      - user: gogs
      - archive: gogs_archive
      - file: config_file
      - file: log_dir
    - watch:
      - file: config_file
      - archive: gogs_archive