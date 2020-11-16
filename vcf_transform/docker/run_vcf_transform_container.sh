#launch an instance of this container and drop into a bash prompt inside it
docker run \
	--name=phyloflow_vcf_transform \
    --rm=true \
	--interactive=true \
    phyloflow/vcf-transform:latest \
	/bin/bash
