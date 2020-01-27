#!/bin/bash

# This script creates a new package from a template.  See the README.

# Get the directory containing this script

pushd $(dirname $0) > /dev/null
base=$(pwd -P)
popd > /dev/null

# Get the input template and output package name

usage () {
    echo "Usage:  $0 <template directory> <package name>"
}

template=$1

if [ "x${template}" = "x" ]; then
    usage
    exit 1
fi

if [ ! -d "${template}" ]; then
    echo "template directory \"${template}\" does not exist"
fi

pkg=$2

if [ "x${pkg}" = "x" ]; then
    usage
    exit 1
fi

if [ -e "${pkg}" ]; then
    echo "output package directory \"${pkg}\" already exists"
fi

# First, check that we have all the tools we need

PYTHON=$(which python3)

if [ "x${PYTHON}" = "x" ]; then
    echo "Cannot find python3"
    exit 1
fi

VERSIONEER=$(which versioneer)

if [ "x${VERSIONEER}" = "x" ]; then
    echo "Cannot find versioneer- did you install it with conda or pip?"
    exit 1
fi

# Copy the template to the output

cp -a "${template}" "${pkg}"

# Move package directory to new name

mv "${pkg}/s4example" "${pkg}/${pkg}"

# Substitute names

find "${pkg}" -type f -exec sed -i -e "s/s4example/${pkg}/g" '{}' \;

# Run versioneer and formatting

pushd "${pkg}" > /dev/null

${VERSIONEER} install
./format_source.sh

popd > /dev/null
