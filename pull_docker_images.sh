# pull the latest version of each docker image from the ncsa's hub.
# this essentially downloads and 'installs' the images to the local machine
#
# This both pulls the image and re-tags it without the hub.ncsa.illinois.edu qualifier
# so that matches the images that's initially built with the dockerfile
# (TODO: there is probably a better way)
docker pull hub.ncsa.illinois.edu/phyloflow/vcf-transform:latest
docker pull hub.ncsa.illinois.edu/phyloflow/pyclone:latest
docker pull hub.ncsa.illinois.edu/phyloflow/pyclone-vi:latest

docker tag hub.ncsa.illinois.edu/phyloflow/vcf-transform:latest phyloflow/vcf-transform:latest
docker tag hub.ncsa.illinois.edu/phyloflow/pyclone:latest phyloflow/pyclone:latest
docker tag hub.ncsa.illinois.edu/phyloflow/pyclone-vi:latest phyloflow/pyclone-vi:latest
