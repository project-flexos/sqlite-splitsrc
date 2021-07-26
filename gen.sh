#!/bin/bash

MAXSIZE=20000
NAME=sqlite-split20k-3300100

git clone https://github.com/sqlite/sqlite.git
pushd sqlite
git checkout version-3.30.1
sed -i -e "s/32768/${MAXSIZE}/g" tool/split-sqlite3c.tcl
./configure
make .target_source
tclsh ./tool/mksqlite3c.tcl
tclsh ./tool/split-sqlite3c.tcl
mkdir $NAME
mv sqlite*.c ${NAME}
mv shell.* ${NAME}
mv sqlite3.h ${NAME}
mv sqlite3ext.h ${NAME}
zip -r ../generated/${NAME}.zip ${NAME}
popd
rm -rf sqlite
