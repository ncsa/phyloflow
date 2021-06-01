echo "Begin build_physigs.sh"
docker build --file=Dockerfile-physigs --tag=phyloflow/physigs:latest ..
echo "Finished build_physigs.sh"