# Python Project Template

This is a simple Python project template with setup.py. This template 
implements i18n and uses nosetests for the automatic testing.

## Project Setup

The following changes need to be applied to use this template for your own
application.

- Change content of tmppackage/__init__.py
- Change name of package within tmppackage/i18n.py
- Rename tmppackage drictory to the name of your application package
- Change TODOs in the bin/tmppackage_bin
- Rename bin/tmppackage_bin to the binary name of your desire
- Setup your tests in the test directory
- Change the values within setup.py
- Change all the tmppackages entry within the Makefile

## Requirements

This package requires the following packages to be usable:

- nose
- coverage

Install them with pip install. The easiest way is to use it with virtualenv.

    $ mkvirtualenv --no-site-packages tmppackage

    $ pip install nose
    ...

## Usage

Run tests

    $ make tests

This runs all the tests and creates a cover directory with the html output of
the coverage report.

### Build packages

    $ make source

### Build the documentation

    $ make documentation

### Create i18n File

    $ make update-pot

If you would like to add a new translation call the msginit command.

    $ cd i18n
    $ msginit --locale=de --input tmppackages.pot

After new string where added the transleted po files need to be updated. For
this call

    $ make i18n/de.po

To test the translation call the make source target since this builds the
translations files and then call the application with the environment set to
the language to test.

    $ make source
    $ LANG=de ./bin/tmppackages_bin
