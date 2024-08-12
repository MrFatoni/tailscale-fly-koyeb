# How to setup Tailscale exit node on fly.io & koyeb

* Open https://login.tailscale.com/admin/settings/keys to `Generate auth key`, pick `Reusable`+`Ephemeral`

### Install and authenticate your `flyctl`

```sh
$ brew install flyctl
$ flyctl auth login
```

### Create a fly.io app from the provided `fly.toml` file

```sh
$ flyctl launch --copy-config
```

### Set the TS_AUTH_KEY env var for the current app.

```sh
$ flyctl secrets set TS_AUTH_KEY=tskey-xxxxx
```

### Create a volume to persist tailscale db.

```sh
$ fly volumes create ts_data --region fra --size 1
```


### Re-deploy, if you change some settings

```sh
$ flyctl deploy
```




### Koyeb deploy, Environment variables tab

add TAILSCALE_AUTHKEY
