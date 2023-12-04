# FastProxy

FastProxy, as its name shows, is a very fast proxy program. It is implemented on the foundation of fasthttp. It supports http/https and it offers multi-service and multi-port support, along with built-in certificate management and configuration file management.

## install

use `curl`:

```sh
curl -sL https://github.com/fastproxy/fastproxy-release/raw/main/install.sh | bash
```

or `wget`:

```sh
wget -O - https://github.com/fastproxy/fastproxy-release/raw/main/install.sh | bash
```

## Usage

### Certificate

You can use `fp cert` command to generate and manage your own certificate, it's very safety.

```sh
fp cert gen [--root] [--inter]

Usage:
  fp cert gen [flags]

Flags:
  -r, --root    Generate a new Root Certificate (default true)
  -i, --inter   Generate a new Intermediate Certificate (default true)
  -h, --help    help for gen
```

And, after generate your own certificate, you can use `fp cert trust` add certificate to your keychain to implement HTTPS proxy.

```sh
fp cert trust [--root] [--inter]

Usage:
  fp cert trust [flags]

Flags:
  -r, --root    Trust the Root Certificate
  -i, --inter   Trust the Intermediate Certificate
  -h, --help    help for trust
```

### Configuration

FastProxy offers a `fp config` command to manage your local configuration files, enabling quick synchronization and switching between different proxy configurations.

Just like `git clone`, you can use `fp config clone` download a configuration files from a web URL.

There are some simple configuration demos in the repo for use: [config](https://github.com/fastproxy/fastproxy-release/tree/main/configs).

```sh
fp config clone https://raw.githubusercontent.com/fastproxy/fastproxy-release/main/configs/static.json
```

And,  `fp config clone` have some flags to config the command:

```sh
Usage:
  fp config clone [flags]

Flags:
  -r, --remote string   Remote Config File URI
  -n, --name string     Use custom name instead of using the remote name
      --default         Set this file as the default configuration file after cloned
  -h, --help            help for clone
```

Then, you can use `fp config list` list all your local configuration files, just like this:

```sh
$ fp config list
Your Download Configuration File:

    1. fileserver (default)
    2. reverse
    3. static
```

Last, you can use `fp config pin` set the default config to easy start a server

```sh
fp config pin reverse
```

## Server Manage

### fp start

As you pin a default configuration files, you can use `fp start` start a reverse proxy server in the background.

or use `fp run` just start in the front.

Also, there is a `config` flag to use a custom file to `start` or `run` a server.

```sh
fp start ./config.json
```

### fp stop

If you want stop the start server in the background, you can just run `fp stop` to stop the server.


# Summarize

1. Download FastProxy.
2. Use `fp cert` command to generate and manage your own certificate.
3. Use `fp config` command to manage your local configuration files.
4. Use `fp start` start a reverse proxy server in the background.
5. Just run `fp stop` to stop the server.

That's All!
