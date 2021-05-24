#!/bin/bash

# eg.
#	> bash run_clusters_to_trees.sh

# Run cluster transform and SPRUCE against the example AML data. Will produce cliques and trees.

PYCLONE_VI_CLUSTER=./example_data/cluster/pyclone_vi_AML_cluster_assignment.tsv
ALPHA=1
PYCLONE_VI_INPUT=./example_data/cluster/pyclone_vi_AML_input.tsv
miniwdl run --dir=runs/ workflows/clusters_to_trees.wdl \
    cluster_type=pyclone-vi \
    cluster_tsv=$PYCLONE_VI_CLUSTER \
    alpha=$ALPHA \
    pyclone_vi_formatted=$PYCLONE_VI_INPUT
