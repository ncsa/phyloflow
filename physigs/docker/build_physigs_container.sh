echo "Begin build_physigs.sh"
WORKING_IMAGE=public.ecr.aws/k1t6h9x8/phyloflow/physigs:latest
DOCKERFILE=Dockerfile-physigs
docker build --file=$DOCKERFILE --tag=$WORKING_IMAGE ..
echo "Finished build_physigs.sh"
