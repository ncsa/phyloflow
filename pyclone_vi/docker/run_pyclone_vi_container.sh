# Runs the container and opens a bash prompt. 
# Useful for inspecting an instance of the container from the inside.
docker run \
	--name=phyloflow_pyclone-vi \
    --rm=true \
	--interactive=true \
    phyloflow/pyclone-vi:latest \
	/bin/bash
