echo "Begin build_vcf_transform.sh"
#docker build --file=Dockerfile-pyclone --tag=phyloflow/pyclone:latest ..
docker build --file=Dockerfile-vcf-transform --tag=phyloflow/vcf-transform:latest ..
echo "Finished build_vcf_transform.sh"
