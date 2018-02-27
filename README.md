# Homebrew Bootstrap
A series of helper scripts to reduce duplication across `script/bootstrap`s.

- [`brew bootstrap-rbenv-ruby`](cmd/brew-bootstrap-rbenv-ruby): Installs Ruby and Bundler.
- [`brew report-issue`](cmd/brew-report-issue.rb): Creates and closes failure debugging issues on a project.
- [`brew bootstrap-nodenv-node`](cmd/brew-bootstrap-nodenv-node): Installs Node and npm.
- [`brew setup-nginx-conf`](cmd/brew-setup-nginx-conf.rb): Generates and installs a project nginx configuration using erb.
- [`brew upgrade-mysql`](cmd/brew-upgrade-mysql): Upgrade MySQL from 5.6 to 5.7 and maintain a development `my.cnf` configuration.
- [`ruby-definitions/`](ruby-definitions): `ruby-build` definitions for GitHub Rubies (from [boxen/puppet-ruby](https://github.com/boxen/puppet-ruby/tree/master/files/definitions)).

## Installation

```bash
brew tap castiron/bootstrap
```

## Usage

```bash
brew bootstrap-rbenv-ruby # or any other script
```

## Contributing

To contribute, the first step is to tap this repository (see installation, above). If you've already tapped it, you'll want to "[unshallow](https://docs.brew.sh/Taps.html)" the tap:

```bash
brew tap castiron/bootstrap --full
```

Once that's done, this repository will be cloned at `/usr/local/Library/Taps/castiron/homebrew-bootstrap`. To make development easier, create a symlink to it in your `~/src` directory:

```bash
cd ~/src
ln -s /usr/local/Library/Taps/castiron/homebrew-bootstrap
```

Assuming this was done correctly, you should see the scripts listed at the top of this repo show up as homebrew commands:

```bash
brew commands list
```

Keep in mind that brew will only include executable files as commands. If you add a new command to this repository, be sure to set permissions correctly. We can write our commands as shell scripts or using ruby. Read the [homebrew documentation on external commands](https://docs.brew.sh/External-Commands) for more information.

## Status

This approach to managing development environments is being actively developed at Cast Iron Coding. Our current intention is to replace Boxen with this set of brew commands, [Strap](https://github.com/MikeMcQuaid/strap), [brew bundle](https://github.com/Homebrew/homebrew-bundle), and a customized version of Github's [one script to rule them all](https://github.com/github/scripts-to-rule-them-all).

There are a number of tasks we'll need to complete before we can make this transition:

### Scaffold project scripts directory
I think it's likely that each type of project we deal with at CIC will have a similar set of scripts. I've created an "install-scripts" command that is meant to be run from within a project directory. For example:

```bash
cd ~/src/cic-wobsite
brew install-scripts rails
```

This command would copy templates/scripts/rails from this project into the cic-wobsite project, where they should be checked into SCM and tracked. By storing these scripts in this bootstrap repo, we have a central place where we can improve on them.

### Scaffold project brewfiles
Each project will have a brewfile listing its brew dependencies. In most cases this will be pretty simple (eg: nginx, imagemagick, mysql). It would be nice to have a mechanism in this bootstrap repo to add a stock brewfile to a project based on the type, similar to what I'm proposing for the scaffolded scripts.

### Standardize on Foreman
The `server` script should, in most cases, just call Foreman. I think we should rely on a procfile in each project for starting app-specific services (Puma, PHP, Sidekiq, etc)

### Store sockets and logs within the project
Boxen centralizes the sockets and the log files in /opt/boxen. I think we should move away from this approach and instead store them where they are most useful, which is within the project directory. On rails projects, the socket should be created in `tmp/sockets` and the nginx log should be stored in `logs/nginx`.

### Manage services with brew services.
Boxen currently manages services. We'll want to change that so that we're using brew services.

### Setup vhosts; deal with nginx
Boxen runs MySQL, Postgres, and Redis on non-standard ports. This makes the transition simpler, because we can install the database services from stock homebrew formulas, and they'll run along side the boxen DB services. Where this gets tricky is with nginx. Because nginx has to listen on standard ports (80 and 443), it's not really possible to run two versions at once.

The `setup-nginx-conf` script that is in this repository will need to be modified for our purposes. It assumes that every project manages its own nginx vhost config file. While that could be useful in some cases, I think we'll want to have a stock nginx file (or files based on project type) in this repository that's used in the event that the project doesn't have one. One thing that the script does, which I think is nice, is that it writes the vhost config to the project config directory, and symlinks to it from the nxing conf dir. This is in keepign with storing all project config, logs, sockets, etc. within the project itself.

I think it's likely that we'll need to adjust this script so that it detects whether boxen nginx is present, and symlinks the files to the non-standard boxen nginx config location.

## Maintainers
- [@zdavis](https://github.com/zdavis/)
- [@gblair](https://github.com/gblair/)
- [@rclarkburns](https://github.com/rclarkburns/)

## License
Homebrew Bootstrap is licensed under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).
The full license text is available in [LICENSE.txt](https://github.com/github/homebrew-bootstrap/blob/master/LICENSE.txt).
