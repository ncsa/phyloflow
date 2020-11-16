## Push an image that exists on this machine (built by build_vcf_transform_container.sh and tagged by tag_latest_image.sh)
## to NCSA's docker hub (the Harbor instance running at hub.ncsa.illinois.edu)
##
## usage:
##   > sh publish_vcf_transform_container.sh v0.1
## or any other tag version that has been created using tag_latest_image.sh 
## 
IMAGE_TAG_TO_PUSH=$1
docker push hub.ncsa.illinois.edu/phyloflow/vcf-transform:$IMAGE_TAG_TO_PUSH
