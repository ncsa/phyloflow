## This is the script that runs *inside* the container and receives the arguments
## from the 'docker run' command to pass to the pycloneexecutable
echo "hello from inside the pyclonecontainer. Does conda work?:"
conda info
conda list
conda env list
echo "running Pyclone help"
conda run -n pyclone PyClone --help 
echo "capturing PyClone help to PyClone_help.txt"
conda run -n pyclone PyClone --help >> PyClone_help.txt
echo "PyClone entrypoint.sh complete"
