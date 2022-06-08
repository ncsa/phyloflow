echo "Begin build_spruce_to_physigs_container.sh"
docker build --file=Dockerfile-spruce-to-physigs --tag=phyloflow/spruce-to-physigs:latest ..
echo "Finished build_spruce_to_physigs_container.sh"
