echo "Begin build_spruce.sh"
WORKING_IMAGE=public.ecr.aws/k1t6h9x8/phyloflow/spruce:latest
DOCKERFILE=Dockerfile-spruce
docker build --file=$DOCKERFILE --tag=$WORKING_IMAGE ..
echo "Finished build_spruce.sh"
