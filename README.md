# Example Templates for S4 Packages

This repository contains example packages that implement the software guidelines defined
in DocDB XXXX as agreed up by the Data Management L2 area.

## Step 1:  Create the New Repository

Go to the CMB-S4 github organization and create the new package following the
agreed-upon naming convention in the DocDB entry above.  Initialize the repository with
a README so that you can check out the repository.

Now clone the repository locally.

## Step 2:  Create the Package Files

Next, clone this s4example repository locally.  From the top level of this git checkout,
choose the correct example starting point (pure python or hybrid python / C++) for your
use case and then run the included script:

    %> ./create.sh <template name> <new package name>

For example:

    %> ./create.sh python s4newpackage

OR

    %> ./create.sh python_cpp s4newpackage

This will produce a directory of files for your new package.  Copy the contents of this
directory into the git checkout for your package.  Use the `-a` option so that "dot"
files (like `.travis`) are copied as well.  For example:

    %> cp -a s4newpackage/ /path/to/git/s4newpackage/

## Step 3:  Commit the Files

Go into your git checkout where you just placed these new files and do:

    %> git status

Then do a `git add` of all these files, commit them, and push the result to github.  Now
you are ready to start working on the new package.  

## Step 4:  Modify Package Files

Edit the setup.py and change the package description to something specific to your
package.  Also change the package URL.  Edit the README file in the new package to
include any additional information about the software.
