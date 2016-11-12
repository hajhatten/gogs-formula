/etc/nginx/conf.d/gogs.conf:
  file.managed:
    - source: salt://gogs/files/nginx-vhost.conf
    - template: jinja
    - makedirs: True
    - require:
      - pkg: nginx

nginx:
  pkg.installed: []
  service.running:
    - service: nginx
    - require:
      - pkg: nginx
      - file: /etc/nginx/conf.d/gogs.conf
    - watch:
      - file: /etc/nginx/conf.d/gogs.conf