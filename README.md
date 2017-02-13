## Isso (comments) for Dokku

This is a Dokku prepared setup for Isso, hosted comments.

It supports multiple virtual hosts out of the box. Simply
add a config file per vhost into the `config/` directory.

### Config file

Copy the example.cfg-dist in the `config/` directory,
update the following fields:

* general.name
* general.host
* general.dbpath

Then commit it to your fork of this repo. Make sure to set the
environment variables as well as documented below.

### Storage Setup

You **must** configure a persistent storage, otherwise every time you restart
the container, you will lose your Isso database.

```
mkdir -p /var/lib/dokku/data/storage/isso
chown -R 32767:32767 /var/lib/dokku/data/storage/isso
dokku storage:mount isso /var/lib/dokku/data/storage/isso:/app/storage
dokku ps:rebuild isso
```

### Environment variables

Depending on what .cfg files you've saved in the `config/` directory,
please set the `ISSO_SETTINGS` environment variable.

E.g. if you've added an `foo.cfg` file to `config/` do this:

```
dokku config:set isso ISSO_SETTINGS="/app/config/foo.cfg"
```

Multiple .cfg files can be specified with a semicolon:

```
dokku config:set isso ISSO_SETTINGS="/app/config/foo.cfg;/app/config/bar.cfg"
```

In additon please make sure to set the following variables so sending
emails works:

```
dokku config:set --no-restart isso ISSO_SMTP_USERNAME=your-smtp-user
dokku config:set --no-restart isso ISSO_SMTP_PASSWORD=your-smtp-password
dokku config:set --no-restart isso ISSO_SMTP_HOST=your-smtp-host
dokku config:set --no-restart isso ISSO_SMTP_PORT=your-smtp-port
dokku config:set --no-restart isso ISSO_SMTP_SECURITY=none|starttls|ssl
dokku config:set --no-restart isso ISSO_SMTP_TO=to-email-address
dokku config:set --no-restart isso ISSO_SMTP_FROM=from-email-address
```
