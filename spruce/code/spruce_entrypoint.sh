## This is the script that runs *inside* the container and receives the arguments
## from the 'docker run' command to pass to the spruceexecutable

## This script must be called with the list of files that are samples
## as defined by spruce 'in-files'.

set -x

>&2 echo "spruce_entrypoint.sh begin."
>&2 echo "list of input files is: $@"

# TODO: spruce pipeline
build_dir="/spruce"

DATA=$1
# INTERVAL=$2
CLIQUE="spruce.cliques"

>&2 echo "SPRUCE: Enumerating cliques" 
$build_dir/cliques -s -1 $DATA > $CLIQUE

>&2 echo "SPRUCE: Running enumerate"
>&2 cat $CLIQUE
>&2 echo "SPRUCE: $DATA, $CLIQUE"
>&2 cat $DATA
# $build_dir/enumerate -clique $CLIQUE -t 2 -v 3 $DATA > spruce.res
# gzip -c spruce.res > spruce.res.gz
# zcat spruce.res.gz | $build_dir/rank - > spruce.merged.res
$build_dir/enumerate -clique $CLIQUE -t 2 -v 3 $DATA > spruce.res
>&2 echo "SPRUCE: Running rank"
cat spruce.res | $build_dir/rank - > spruce.merged.res

>&2 echo "spruce_entrypoint.sh finished."
