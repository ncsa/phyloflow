echo "Begin build_cluster_transform.sh"
WORKING_IMAGE=public.ecr.aws/k1t6h9x8/phyloflow/cluster_transform:latest
DOCKERFILE=Dockerfile-cluster-transform
docker build --file=$DOCKERFILE --tag=$WORKING_IMAGE ..
echo "Finished build_cluster_transform.sh"
