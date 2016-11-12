{% from "gogs/map.jinja" import gogs with context %}
{% set config = gogs.config %}
{% set db = gogs.database %}

{% if grains['os_family'] == 'RedHat' %}

postgresql_packages:
  pkg.installed:
    - pkgs:
      - postgresql-server
      - postgresql-contrib

setup_init_db:
  cmd.wait:
    - name: postgresql-setup initdb
    - watch:
      - pkg: postgresql_packages

{% elif grains['os_family'] == 'Debian' %}

postgresql_packages:
  pkg.installed:
    - pkgs:
      - postgresql
      - postgresql-contrib

{% endif %}


postgresql:
  service.running:
    - enable: True
    - require:
      - pkg: postgresql_packages

gogs_postgresql_db:
  postgres_user.present:
    - name: {{ db['user'] }}
    - password: {{ db['password'] }}
    - encrypted: True
  postgres_database.present:
    - name: {{ db['database'] }}
    - owner: {{ db['user'] }}