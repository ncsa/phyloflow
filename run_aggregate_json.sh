#!/bin/bash

# eg.
#   > bash run_aggregate_json.sh

VEP_FILE=./example_output/VEP_raw.moss.mutect2.filtered.vcf
CLUSTER_ASSIGNMENT=./example_data/cluster/pyclone_vi_AML_cluster_assignment.tsv
SPRUCE_JSON=./example_output/spruce.res.json
SPRUCE_RES=./example_output/spruce.res.gz

miniwdl run --dir=runs/ aggregate_json/aggregate-json-task.wdl \
    vep_file=$VEP_FILE \
    cluster_assignment=$CLUSTER_ASSIGNMENT \
    spruce_json=$SPRUCE_JSON \
    spruce_res=$SPRUCE_RES
