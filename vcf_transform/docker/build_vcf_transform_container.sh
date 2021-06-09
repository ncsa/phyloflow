echo "Begin build_vcf_transform.sh"
WORKING_IMAGE=public.ecr.aws/k1t6h9x8/phyloflow/vcf_transform:latest
DOCKERFILE=Dockerfile-vcf-transform
docker build --file=$DOCKERFILE --tag=$WORKING_IMAGE ..
echo "Finished build_vcf_transform.sh"
