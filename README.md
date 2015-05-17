# Vagrant-Solaris10

[![Build Status](http://img.shields.io/travis/tnarik/vagrant-solaris10.svg)](https://travis-ci.org/tnarik/vagrant-solaris10)
[![Code Climate](http://img.shields.io/codeclimate/github/tnarik/vagrant-solaris10.svg)](https://codeclimate.com/github/tnarik/vagrant-solaris10)
[![Coveralls](http://img.shields.io/coveralls/tnarik/vagrant-solaris10.svg)](https://coveralls.io/r/tnarik/vagrant-solaris10)
[![RubyGems](http://img.shields.io/gem/v/vagrant-solaris10.svg)](http://rubygems.org/gems/vagrant-solaris10)
[![Gemnasium](http://img.shields.io/gemnasium/tnarik/vagrant-solaris10.svg)](https://gemnasium.com/tnarik/vagrant-solaris10)

# Description

This is a Vagrant plugin for Solaris 10.
As opossed to the default implementation of the Vagrant Solaris 10 plugin part of Vagrant, this implementation tries to avoid non Solaris tools or approaches, as the main target is a 'as pure as possible' Solaris 10 machine. This means most of the tools installed in the system will be default Solaris one and not GNU replacements. GNU replacements, when installed, are available as separate commands, straight from the installation packages.

The main machine this plugin is used with is [my Solaris10 Packer build](https://github.com/tnarik/basebox-solaris10).

## Installation

Install via Vagrant

```zsh
$ vagrant plugin install vagrant-solaris10
```

To install from source code, first build via `rake` and then:

```zsh
$ vagrant plugin install pkg/vagrant-solaris10-x.x.x.gem
```

## Contributing

1. Fork it ( https://github.com/tnarik/vagrant-solaris10/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Authors

- Tnarik Innael (@tnarik) 
- Mitchell Hashimoto (@mitchellh) : portions of code used as base for capability implementation, from the original [Vagrant](https://github.com/mitchellh/vagrant) plugins code (1.6.5->1.7.x). Specific attribution will appear per file/method.