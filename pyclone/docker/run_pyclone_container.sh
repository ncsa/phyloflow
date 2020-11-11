#--workdir=/code/ \
docker run \
	--name=phyloflow_pyclone \
    --rm=true \
    phyloflow/pyclone:latest \
	sh /code/pyclone_entrypoint.sh
