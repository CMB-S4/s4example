# CMB-S4 Package s4example

This package is an example.  Add more description here...


## Package Installation

This package uses setuptools for package installation.  You can use the setup.py directly for installation or use pip.  Using pip makes it easier to uninstall the package cleanly.  Installation with setup.py to a specific location can be done with:

    %>  python3 setup.py install --prefix /some/place

OR

    %>  pip3 install --install-option="--prefix='/some/place'"

If you do not specify a `--prefix` option, the package will be installed to your python
installation prefix.  If you are using a virtualenv or a conda environment for your
development work (always a good idea!) then it is safe to leave out the `--prefix`
option and install the package into your environment.

If you want to be able to edit the source and have those changes show up in your
environment without re-installing, then you can use the package in develop / editable
mode.  This is done slightly differently depending on whether you use setup.py directly
or pip:

    %>  python3 setup.py develop --prefix /some/place

OR

    %>  pip3 -e install --install-option="--prefix='/some/place'"


## Running Unit Tests

The unit tests are contained within the package itself.  This has the benefit that we
are certain to be running the tests on the installed package, rather than running tests
against a locally built (and perhaps different) version of the package.  After
installing the package (or using the develop / editable option), run tests with:

    %> python3 -c 'import s4example.tests; s4example.tests.run()'


## Package Development

When developing the code, you should install (e.g. with pip or conda) the "black" python
formatting package.  When making changes to the source, and before committing, run the
`format_source.sh` script in the top directory.  This applies formatting rules to all
the source files.

See DocDB XXXX for relevant coding guidelines.
