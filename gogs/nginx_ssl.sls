pyOpenSSL:
  pkg.installed

self_signed_cert:
  module.wait:
    - name: tls.create_self_signed_cert
    - require:
      - pkg: pyOpenSSL
    - watch:
      - pkg: pyOpenSSL