#!/bin/bash

# eg.
#	> bash run_workflow_example1.sh

# Run vcf_transform against the example data that it comes with. Will produce outputs for
# both pyclone and pyclone_vi to input.

FILE=./example_data/mek_lab_vcfs/A25.mutect2.filtered.snp.vcf
miniwdl run --dir=runs/ workflows/vcf_to_clusters.wdl vcf_type=mutect vcf_input_file=$FILE
