echo "Begin build_pyclone.sh"
#docker build --file=Dockerfile-pyclone --tag=phyloflow/pyclone:latest ..
docker build --file=Dockerfile-pyclone --tag=phyloflow/pyclone:latest ..
echo "Finished build_pyclone.sh"
