#!/bin/bash

# eg.
#	> bash run_workflow_vcf_to_trees.sh

# Run . Will produce 

FILE=./example_data/mek_lab_vcfs/moss.mutect2.filtered.vcf
miniwdl run --dir=runs/ workflows/vcf_to_trees.wdl vcf_type=moss vcf_input_file=$FILE alpha=1
