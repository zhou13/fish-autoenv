# Autoenv

#### Autoenv automatically sources (known/whitelisted) `.autoenv.fish` and `.autoenv_leave.fish` files.

This is a fork of [aohorodnyk/fish-autovenv](ttps://github.com/aohorodnyk/fish-autovenv), which is a FISH Shell port of [horosgrisa/autoenv](https://github.com/horosgrisa/autoenv).

## Features

- Installable via `fisher`
- Use `.autoenv.fish` for entering and `.autoenv_leave.fish` for leaving instead of `.env.fish` and `.out.fish` by default
- Autoenv files can be configured via environment variables `AUTOENV_FILE_ENTER` and
  `AUTOENV_FILE_LEAVE`.
- Reliable on startup

## Installation

This package can be installed via `fisher`:

```sh
fisher install zhou13/fish-autoenv
```

## Configuration

You can use the following variables to control fish-autoenv behavior.

### AUTOENV_FILE_ENTER

Name of the file to look for when entering directories.

Default: `.autoenv.fish`

### AUTOENV_FILE_LEAVE

Name of the file to look for when leaving directories.
Requires `AUTOENV_HANDLE_LEAVE=1`.

Default: `.autoenv_leave.fish`
