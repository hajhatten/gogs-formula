================
gogs-formula
================

This sets up Go Git Service.

    See the `configuration cheat sheet for configuration options
    <https://gogs.io/docs/advanced/configuration_cheat_sheet>`_.

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================


``gogs``
------------

Installs the gogs archive, and starts the associated gogs service.


``gogs.uninstall``
------------------

Uninstalls the gogs archive, and removes the associated gogs service.


``gogs.nginx``
------------------

Installs nginx as a proxy to gogs.


``gogs.nginx_ssl``
------------------

If you're fine with a self-signed tls certi for nginx, use this state.