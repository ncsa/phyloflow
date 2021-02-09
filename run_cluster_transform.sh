#!/bin/bash

# eg.
#	> bash run_pyclone_example1.sh

# Run cluster_transform against the example data that it comes with. Will produce outputs for
# both pyclone and pyclone_vi to input.

PYCLONE_VI_CLUSTER=./example_data/cluster/pyclone_vi_cluster_assignment.tsv
PYCLONE_VI_INPUT=./example_data/cluster/pyclone_vi_input.tsv
miniwdl run --dir=runs/ cluster_transform/cluster-transform-task.wdl \
    cluster_type=pyclone-vi \
    cluster_tsv_file=$PYCLONE_VI_CLUSTER \
    pyclone_vi_formatted=$PYCLONE_VI_INPUT
