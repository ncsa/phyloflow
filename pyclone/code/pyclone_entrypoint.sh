## This is the script that runs *inside* the container and receives the arguments
## from the 'docker run' command to pass to the pyclone executable
echo "hello from inside the pyclone container. Does conda work?:"
conda info
echo "entrypoint.sh complete"
