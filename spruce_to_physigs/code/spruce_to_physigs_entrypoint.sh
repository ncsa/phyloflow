## This is the script that runs *inside* the container and receives the arguments
## from the wdl runtime to pass to the spruce_to_physigs python code

# This script expects 3 args
# $1 tsv: path to a TSV file containing variants produced by the pipeline 'vcf_transform'
# $2 json: path to a JSON file containing tree edges produced by the pipeline 'spruce'
# $3 prefix: output prefix
# It returns 2 CSV files
#   tree.csv
#   snvs.csv


echo "spruce_to_physigs.sh: begin."
echo "spruce_to_physigs.sh: list of input args from wdl runtime: $@"
python -B -m py_code.main -t $1 -j $2 -o $3
echo "spruce_to_physigs.sh: finished."
