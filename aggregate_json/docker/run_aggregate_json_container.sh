#launch an instance of this container and drop into a bash prompt inside it
# WORKING_IMAGE=public.ecr.aws/k1t6h9x8/phyloflow/aggregate_json:latest
WORKING_IMAGE=phyloflow/aggregate_json:latest
docker run \
	--name=bash_aggregate_json \
    --rm=true \
	--interactive=true \
    $WORKING_IMAGE \
	/bin/bash

