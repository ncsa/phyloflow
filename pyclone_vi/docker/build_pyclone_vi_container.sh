echo "Begin build_pyclone-vi.sh"

WORKING_IMAGE=public.ecr.aws/k1t6h9x8/phyloflow/pyclone_vi:latest
DOCKERFILE=Dockerfile-pyclone-vi
docker build --file=$DOCKERFILE --tag=$WORKING_IMAGE ..
echo "Finished build_pyclone-vi.sh"
