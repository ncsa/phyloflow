#launch an instance of this container and drop into a bash prompt inside it
WORKING_IMAGE=public.ecr.aws/k1t6h9x8/phyloflow/physigs:latest
docker run \
	--name=bash_physigs \
    --rm=true \
	--interactive=true \
    $WORKING_IMAGE \
	/bin/bash

