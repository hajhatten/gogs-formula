{% if grains['os_family'] == 'RedHat' %}

config_file:
  file.managed:
    - name: /etc/nginx/conf.d/gogs.conf
    - source: salt://gogs/files/nginx-vhost.conf
    - template: jinja
    - makedirs: True
    - require:
      - pkg: nginx

{% else %}

config_file:
  file.managed:
    - name: /etc/nginx/sites-available/gogs.conf
    - source: salt://gogs/files/nginx-vhost.conf
    - template: jinja
    - makedirs: True
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/gogs.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/gogs.conf
    - makedirs: True
    - require:
      - pkg: nginx
      - file: /etc/nginx/sites-available/gogs.conf

{% endif %}

nginx:
  pkg.installed: []
  service.running:
    - service: nginx
    - require:
      - pkg: nginx
      - file: config_file
    - watch:
      - file: config_file