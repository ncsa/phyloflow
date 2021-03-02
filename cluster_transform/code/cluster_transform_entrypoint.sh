## This is the script that runs *inside* the container and receives the arguments
## from the wdl runtime to pass to the cluster_transform python code

# This script expects two args
# $1 cluster_type: pyclone or pyclon-vi
# $2 cluster_file: path to a cluster_file produced by the pipeline type 'cluster_type'
# $3 output_file: data file input to SPRUCE
# $4 pyclone_vi_input_file: only used for pyclone-vi, used for extracting VAF
#		Note that when using inside of wdl, wdl will change the filename and mount
#		it into the container for you (and that is the version this script will recieve)

echo "cluster_transform_entrypoint.sh: begin."
echo "cluster_transform_entrypoint.sh: list of input args from wdl runtime: $@"
if [ $# -eq 3 ]; then
    conda run -n cluster-transform python -B -m py_code.main -t $1 -c $2 -o $3
elif [ $# -eq 4 ]; then
    conda run -n cluster-transform python -B -m py_code.main -t $1 -c $2 -o $3 -v $4
else
    echo "cluster_transform_entrypoint.sh: wrong number of input args, only 3 or 4 allowed."
fi
echo "cluster_transform_entrypoint.sh: finished."
