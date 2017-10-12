# Pencil Durability Kata
 * User stories taken from https://github.com/PillarTechnology/kata-pencil-durability

## How to build
* Project was built using ruby version 2.3.1 and ruby-bundler version 1.16.0 on Ubuntu 16.04
* If ruby or the ruby-bundler is not installed the following command can be used for Ubuntu and Debian
~~~~
$ sudo apt install ruby ruby-bundler
~~~~

* To install the necessary dependencies use the following command in the project directory
~~~~
$ bundle install
~~~~
  * The dependencies are as follows
    * RSpec version 3.6.0
    * YARD version 0.9.9
  * RSpec was used to create and run the test framework
  * YARD was used to create documentation

## How to run
* After running the bundler the following command can be used to to run tests
~~~~
$ rake
~~~~
* Or to run the tests directly with the RSpec gem in the project directory you can run the following command
~~~~
$ rspec spec/
~~~~
* Results will be printed to stdout


## How to view documentation
* After running the bundler the following command can be used to to view formatted documentation
to http://localhost:8808/
~~~~
$ yard server
~~~~
