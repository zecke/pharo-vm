#!/usr/bin/env bash

if [ ! -e vmVersionInfo.h ]; then
	../scripts/extract-commit-info.sh
fi
cmake -DCMAKE_C_COMPILER=/usr/bin/gcc .
make

