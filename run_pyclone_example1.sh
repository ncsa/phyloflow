#!/bin/bash

# !!!! THIS MUST BE RUN WITH BASH, NOT sh !!!!
# eg.
#	> bash run_pyclone_example1.sh

# Run PyClone against the example data that it comes with. 
# There is no translation step as the inputs are already prepared by the PyClone authors.
# This runs the wdl 'task' directly, not part of an encapsulating 'workflow'

# miniwdl requires that an array of file inputs for key1 be given as a series
# of arguments key1=file1 key1=file2 key1=file3 etc
# So gather the sample files with a glob into a bash array and then create the
# series of arguments by prepending 'tsv_sample_files=' to each entry
FILES_ARY=( ./example_data/pyclone_tsvs/*.tsv )
echo "FILES_ARY: ${FILES_ARY[@]}"
PARAMS=${FILES_ARY[@]/#/tsv_sample_files=}
#echo "Final Params to pass to wdl: $PARAMS"
miniwdl run --dir=runs/ pyclone/pyclone-task.wdl $PARAMS



