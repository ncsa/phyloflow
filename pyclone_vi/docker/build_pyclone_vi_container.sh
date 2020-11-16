echo "Begin build_pyclone-vi.sh"
#docker build --file=Dockerfile-pyclone --tag=phyloflow/pyclone:latest ..
docker build --file=Dockerfile-pyclone-vi --tag=phyloflow/pyclone-vi:latest ..
echo "Finished build_pyclone-vi.sh"
