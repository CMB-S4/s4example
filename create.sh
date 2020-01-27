#!/bin/bash

# This script creates a new package from a template.  See the README.

# Get the directory containing this script

pushd $(dirname $0) > /dev/null
base=$(pwd -P)
popd > /dev/null

# Get the input template and output package name

usage () {
    echo "Usage:  $0 <template directory> <package name> <new git repo location>"
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

gitpkg=$3

if [ "x${gitpkg}" = "x" ]; then
    usage
    exit 1
fi

if [ ! -d "${gitpkg}" ]; then
    echo "package git directory \"${gitpkg}\" does not exist"
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

# Does this template include pybind11?

check_cpp=$(echo "${template}" | sed -e "s#.*\(cpp\).*#\1#")
pybind_version=2.4.3

# Copy the template to the output

rsync -a "${template}/" "${gitpkg}/"

# Substitute names

mv "${gitpkg}/s4example" "${gitpkg}/${pkg}"
if [ "x${check_cpp}" = "xcpp" ]; then
    # Rename the bindings
    mv "${gitpkg}/${pkg}/_s4example.cpp" "${gitpkg}/${pkg}/_${pkg}.cpp"
fi
find "${gitpkg}" -type f -exec sed -i -e "s/s4example/${pkg}/g" '{}' \;

# Run versioneer, formatting, and get pybind11 if needed.

pushd "${gitpkg}" > /dev/null

${VERSIONEER} install

if [ "x${check_cpp}" = "xcpp" ]; then
    curl -SL https://github.com/pybind/pybind11/archive/v${pybind_version}.tar.gz -o pybind11-${pybind_version}.tar.gz
    tar xzvf pybind11-${pybind_version}.tar.gz -C ${pkg} --strip-components=2 pybind11-${pybind_version}/include/pybind11
    rm -f pybind11-${pybind_version}.tar.gz
fi

./format_source.sh

popd > /dev/null
