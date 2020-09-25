## Push an image that exists on this machine (built by build_pyclone_container.sh and tagged by tag_latest_image.sh)
## to NCSA's docker hub (the Harbor instance running at hub.ncsa.illinois.edu)
##
## usage:
##   > sh publish_pyclone.sh v0.1
## or any other tag version that has been created using tag_latest_image.sh 
## 
IMAGE_TAG_TO_PUSH=$1

#this bot account configured at https://hub.ncsa.illinois.edu/harbor/projects/13/robot-account
BOT_NAME="robot$phylobot"
BOT_TOKEN="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2MDEwNTk1NTcsImlzcyI6ImhhcmJvci10b2tlbi1kZWZhdWx0SXNzdWVyIiwiaWQiOjU2NTg4LCJwaWQiOjEzLCJhY2Nlc3MiOlt7IlJlc291cmNlIjoiL3Byb2plY3QvMTMvcmVwb3NpdG9yeSIsIkFjdGlvbiI6InB1c2giLCJFZmZlY3QiOiIifSx7IlJlc291cmNlIjoiL3Byb2plY3QvMTMvaGVsbS1jaGFydCIsIkFjdGlvbiI6InJlYWQiLCJFZmZlY3QiOiIifSx7IlJlc291cmNlIjoiL3Byb2plY3QvMTMvaGVsbS1jaGFydC12ZXJzaW9uIiwiQWN0aW9uIjoiY3JlYXRlIiwiRWZmZWN0IjoiIn1dfQ.jLC9dlQrHb2rXRkB0qrz52XvslE5rOQZlfnWn6Wgb77R0mgsplSd0qie2X8RnauUqIGt3lsV6zA4hbE8R2un7oi22jkJGtw76Yg049xecrwor_vtf17H7matttJDwmHTwcjdnonwyUlJGAbLZqB9q3pZ4LN5Axgz0_89njvNCq-lpDEQDjsiPk0jd9wIJ5-4XN4ochxkmpVGLA3LcMWwyhKd7LPLFXn4tHZEBbuD1e9bEFOo4iNlhwSjx1WRJm1dVbipmDcECsHXO8zSvZdbYmtZ6X515s4ZWXU8WwFa3uFwCsYx9lvJWaQGgb1-yXAs5xHbCUp9648Ew3TAayi4pdqdwBio-CAZGXfw-ElknVr5aUdfM_5nMvyqhquFVt3D1IW9T-s912Po1NyZjt5YToQOrbyGMRO_CQFiINEsChoJJ5u_lNNOIxbiOdudptMAxek3rYJhMTX6ggNMZ0_JmO4P_HSeTyOImqStmMFOCNw_wuAzFzufPEbF_h1qU92E0kOCyc_40eApoWR3nSOxLWp7IaK60xloKUmz_aRIoQDDMXQYCmEUhV4aSlBZb_ksZhaxEsAfBrqWBsNVi5S1iFMloNeKziVhnRpkmxjQxZzgY7__PyquvE8FN8C8J8suK93o3gz1aqbnAnNs7hlWhToc6-JqsEyQvXX5rsLLv0o"

docker login --username=$BOT_NAME --password=$BOT_TOKEN
docker push hub.ncsa.illinois.edu/phyloflow/pyclone:$IMAGE_TAG_TO_PUSH