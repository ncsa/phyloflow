echo "Begin build_aggregate_json.sh"
# WORKING_IMAGE=public.ecr.aws/k1t6h9x8/phyloflow/aggregate_json:latest
WORKING_IMAGE=phyloflow/aggregate-json:latest
DOCKERFILE=Dockerfile-aggregate-json
docker build --file=$DOCKERFILE --tag=$WORKING_IMAGE ..
echo "Finished build_aggregate_json.sh"
