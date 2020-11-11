# Run PyClone against the example data that it comes with. 
# There is no translation step as the inputs are already prepared by the PyClone authors.
# This runs the wdl 'task' directly, not part of an encapsulating 'workflow'
FILES="./example_data/pyclone_tsvs/*.tsv"
echo $FILES
miniwdl run --dir=runs/ pyclone/pyclone-task.wdl tsv_sample_files=./example_data/pyclone_tsvs/SRR385941.tsv



