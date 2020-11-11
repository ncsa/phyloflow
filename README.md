# Phyloflow
Phylogenic tree computations packaged with Docker and WDL.

This repo contains tools to package commandline tools from the field
of cancer phylogeny into workflow building blocks including:
- A Dockerfile for each individual computational tool.
- WDL task definitions that define the inputs and outputs of each tool (and use the docker container for execution)
- Scripts to push built docker images to the NCSA docker repo (hub.ncsa.illinois.edu) (needs api keys)
- Scripts to pull docker images from hub.ncsa.illinois.edu
- Sample WDL workflows that contain the above tasks.
- Example scripts to run the workflows using miniwdl at the commandline, using example data from this repo.

## Installation

Requires miniwdl 0.9



## References

Workflow Description Language (WDL)
