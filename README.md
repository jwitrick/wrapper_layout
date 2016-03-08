chef_workstation Cookbook
=========================
This cookbook will setup a chefdk workstation in aws.


Requirements
------------

#### Recipes
Cookbook Name | Location
------------- | --------
chef-dk | Supermarket
python | Supermarket
awscli | Supermarket

Usage
-----
#### chef_workstation::default

Just include `chef_workstation` in your nodes

Testing
=======

This cookbook comes with a ruby Rakefile that can run all the tests and checks.

to use first install all proper rubygems: `chef exec bundle install` then
run `chef exec rake`.

Contributing
============

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

License and Authors
===================

Author:: Justin Witrick(github@thewitricks.com)
