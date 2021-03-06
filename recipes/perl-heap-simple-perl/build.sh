#!/bin/bash

sed -i.bak 's|VERSION = "0.12"|VERSION = "0.14"|g' lib/Heap/Simple/Perl.pm # Typo in 0.14 version, evaluated by perl-heap-simple

# If it has Build.PL use that, otherwise use Makefile.PL
if [ -f Build.PL ]; then
    perl Build.PL
    ./Build
    #./Build test # expected to fail as we don't had perl-heap-simple as dep to avoid cyclic dependency
    # Make sure this goes in site
    ./Build install --installdirs site
elif [ -f Makefile.PL ]; then
    # Make sure this goes in site
    perl Makefile.PL INSTALLDIRS=site
    make
    #make test # expected to fail as we don't had perl-heap-simple as dep to avoid cyclic dependency
    make install
else
    echo 'Unable to find Build.PL or Makefile.PL. You need to modify build.sh.'
    exit 1
fi
