redmine_status_history
==============================

This plugin allows users to search over the status changes of a issue

Features
--------

* Allows search over the status changes of a issue
* Limit its usage with a permission in issue tracking module

Compatibility
-------------

Developed and tested on redmine 2.x

Usage
-----

[See wiki] (https://github.com/javiferrer/redmine_status_history/wiki)

Installation
------------

* Clone https://github.com/javiferrer/redmine_status_history or download zip into  **redmine_dir/plugins/** folder
```
$ git clone https://github.com/javiferrer/redmine_status_history.git
```
* Stop redmine. From redmine root directory, run (it takes a long time if you have a lot of issues): 
```
$ rake redmine:plugins:migrate RAILS_ENV=production
```
* Restart redmine

Licence
-------

GNU General Public License Version 2
