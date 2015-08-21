Autoenv
=======

#### Autoenv automatically sources (known/whitelisted) `.env.fish` and `.out.fish` files.

This is a FISH Shell port of [horosgrisa/autoenv](https://github.com/horosgrisa/autoenv). Please go check it if you're using ZSH.

This plugin support for enter and leave events. By default `.env.fish` is used for entering, and `.out.fish` for leaving.

## Example of use

- If you are in the directory `/home/user/dir1` and execute `cd /var/www/myproject` this plugin will source following files if they exist
```
/home/user/dir1/.out.fish
/home/user/.out.fish
/home/.out.fish
/var/.env.fish
/var/www/.env.fish
/var/www/myproject/.env.fish
```

- If you are in the directory `/` and execute `cd /home/user/dir1` this plugin will source following files if they exist
```
/home/.env.fish
/home/user/.env.fish
/home/user/dir1/.env.fish
```

- If you are in the directory `/home/user/dir1` and execute `cd /` this plugin will source following files if they exist
```
/home/user/dir1/.out.fish
/home/user/.out.fish
/home/.out.fish
```

## Example of `.env.fish` and `.out.fish` files useful for node.js developing

### .env.fish

```sh
nvm use node
set -g OLDPATH $PATH
set -gx PATH (pwd)/node_modules/.bin $PATH
```

### .out.fish
```sh
nvm use system
set -gx PATH $OLDPATH
```

## Installation

Clone the repo to somewhere and just source `autoenv.fish`

```sh
git clone https://github.com/eknkc/fish-autoenv.git
cd fish-autoenv
. autoenv.fish
```

