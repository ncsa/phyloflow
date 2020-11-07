## This is the script that runs *inside* the container and receives the arguments
## from the 'docker run' command to pass to the pyclone-vi executable
echo "hello from inside the pyclone-vi container. Does conda work?:"
conda info
conda list
conda env list
echo "running pyclone-vi help"
conda run -n pyclone-vi pyclone-vi --help 
echo "capturing pyclone-vi help to pyclonevi_help.txt"
conda run -n pyclone-vi pyclone-vi --help >> pyclonevi_help.txt
echo "entrypoint.sh complete"
