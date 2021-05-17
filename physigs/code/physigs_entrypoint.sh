## This is the script that runs *inside* the container and receives the arguments
## from the wdl runtime to pass to the physigs python code

# This script expects two args
# $1 tree_csv: a CSV file with rows containing edges of the tumor phylogeny
# $2 snv_csv: a CSV file of SNVs
# $3 output_prefix: prefix of the output files, will produce `*.plot.pdf`, `*.tree.tsv`, and `*.exposure.tsv`.
# $4 signatures.txt: a file contains a subset of COSMIC v2 signatures to be used. 1 in each row.
#		Note that when using inside of wdl, wdl will change the filename and mount
#		it into the container for you (and that is the version this script will recieve)

echo "physigs_entrypoint.sh: begin."
echo "physigs_entrypoint.sh: list of input args from wdl runtime: $@"
if [ $# -eq 3 ]; then
    Rscript run_physigs.R $1 $2 $3
elif [ $# -eq 4 ]; then
    Rscript run_physigs.R $1 $2 $3 $4
else
    echo "physigs_entrypoint.sh: wrong number of input args, only 3 or 4 allowed."
fi
echo "physigs_entrypoint.sh: finished."
