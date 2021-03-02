#launch an instance of this container and drop into a bash prompt inside it
docker run \
	--name=phyloflow_cluster_transform \
    --rm=true \
	--interactive=true \
    phyloflow/cluster-transform:latest \
	/bin/bash
