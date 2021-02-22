echo "Begin build_spruce.sh"
docker build --file=Dockerfile-spruce --tag=phyloflow/spruce:latest ..
echo "Finished build_spruce.sh"