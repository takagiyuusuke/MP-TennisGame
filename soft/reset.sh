#!/bin/bash

#cp test.03.c test.c
# Navigate to the current directory
make clean
make

# Navigate to the hard directory
cd ../hard
make clean
make
make program

# Navigate back to the soft directory
cd ../soft


