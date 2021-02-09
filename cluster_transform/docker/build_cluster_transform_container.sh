echo "Begin build_cluster_transform.sh"
#docker build --file=Dockerfile-pyclone --tag=phyloflow/pyclone:latest ..
docker build --file=Dockerfile-cluster-transform --tag=phyloflow/cluster-transform:latest ..
echo "Finished build_cluster_transform.sh"
