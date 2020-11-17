## Push an image that exists on this machine (built by build_pyclone_container.sh and tagged by tag_latest_image.sh)
## to NCSA's docker hub (the Harbor instance running at hub.ncsa.illinois.edu)
##
## usage:
##   > sh publish_pyclone.sh v0.1
## or any other tag version that has been created using tag_latest_image.sh 
## 
IMAGE_TAG_TO_PUSH=$1
docker push hub.ncsa.illinois.edu/phyloflow/pyclone-vi:$IMAGE_TAG_TO_PUSH
docker push hub.ncsa.illinois.edu/phyloflow/pyclone-vi:latest
