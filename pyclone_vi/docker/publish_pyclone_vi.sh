## Push an image that exists on this machine (built by build_pyclone_vi_container.sh) 
## to NCSA-VISA's ElasticContainerRegistry
##
## usage:
##   > sh publish_pyclone_vi_container.sh v0.1
## or any other tag version that exists locally (shows with on `docker image ls`)
## 
IMAGE_TAG_TO_PUSH=$1
WORKING_IMAGE=public.ecr.aws/k1t6h9x8/phyloflow/pyclone_vi:$IMAGE_TAG_TO_PUSH
docker push $WORKING_IMAGE

