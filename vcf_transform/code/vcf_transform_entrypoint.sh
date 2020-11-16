## This is the script that runs *inside* the container and receives the arguments
## from the 'docker run' command to pass to the pycloneexecutable

## This script must be called with the list of files that are samples
## as defined by pyclone 'in-files'. 
## see https://github.com/Roth-Lab/pyclone

echo "vcf_transform_entrypoint.sh begin."
pwd
echo "list of input args is: $@"
conda run -n vcf-transform python -B -m py_code.main $@
echo "vcf_tranform_entrypoint.sh finished."
