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

## Status

This approach to managing development environments is being actively developed at Cast Iron Coding. 


## Contact
[@zdavis](https://github.com/zdavis/)
[@gblair](https://github.com/gblair/)

## License
Homebrew Bootstrap is licensed under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).
The full license text is available in [LICENSE.txt](https://github.com/github/homebrew-bootstrap/blob/master/LICENSE.txt).
