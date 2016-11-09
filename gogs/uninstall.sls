{% from "gogs/map.jinja" import gogs with context %}
{% set config = gogs.config %}
{% set repo = gogs.repository %}

{{ config['install_dir'] }}:
  file.absent

config_file:
  file.absent:
    - name: {{ config['install_dir'] }}/custom/conf/app.ini

repo_dir:
  file.absent:
    - name: {{ repo['repository_path'] }}
  
log_dir:
  file.absent:
    - name: {{ config['log_dir'] }}

gogs_user:
  user.absent

gogs_service:
  service.dead:
    - name: gogs

/etc/systemd/system/gogs.service:
  file.absent

