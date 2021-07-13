#!/bin/bash

PHYSIGS_TREE=./example_data/physigs/tree.csv
PHYSIGS_SNV=./example_data/physigs/snv.csv
PHYSIGS_SIGNATURES=./example_data/physigs/signatures.txt

miniwdl run --dir=runs/ physigs/physigs-task.wdl \
    tree_csv=$PHYSIGS_TREE \
    snvs_csv=$PHYSIGS_SNV \
    signatures=$PHYSIGS_SIGNATURES

