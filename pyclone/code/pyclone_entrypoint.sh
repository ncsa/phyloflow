## This is the script that runs *inside* the container and receives the arguments
## from the 'docker run' command to pass to the pycloneexecutable

## This script must be called with the list of files that are samples
## as defined by pyclone 'in-files'. 
## see https://github.com/Roth-Lab/pyclone

echo "pyclone_entrypoint.sh begin."
#echo "hello from inside the pyclonecontainer. Does conda work?:"
#conda info
#conda list
#conda env list
#echo "running Pyclone help"
#conda run -n pyclone PyClone --help 
echo "list of input files is: $@"
conda run -n pyclone PyClone run_analysis_pipeline --working_dir . --in_files "$@"
echo "pyclone_entrypoint.sh finished."
