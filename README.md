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

This is currently a *PROTOTYPE* and is meant to be a demonstration of WDL and
Docker to experiment with deployment options, not to produce fine-tuned or even
believable results without additional QC.

## Workflow1: vcf_to_clusters

This repo currently contains the WDL tasks and workflow to:
1. Load a VCF file produced by 'mutect'.
2. Transform the VCF's mutations into the input formats of 'pyclone' and 'pyclone-vi' as a task.
3. Run 'pyclone' and 'pyclone-vi' as separate tasks concurrently.
4. Collect the output tsv files which contain clusters of the mutations. They should be
similar results but pyclone-vi will complete much faster.

## Installation

### Prereqs
- Example scripts require miniwdl 0.9. If you have conda installed:
        
        conda install miniwdl

- Requires docker installed on the local machine, with the current user in group 'docker'

### Docker images

The wdl tasks each have their own docker image that must be stored locally. You may either pull
the images from the NCSA's docker hub or build from Dockerfile's using the provided scripts.

To download and install from NCSA's hub, use the provided script:

    sh pull_docker_images.sh

OR to build the images yourself:

    cd pyclone/docker 
    sh build_pyclone_container.sh

    cd ../../pyclone_vi/docker
    sh build_pyclone_vi_container.sh

    cd ../../vcf_transform/docker
    sh build_vcf_transform_container.sh

## Isolated Task Examples
Each WDL Task has a script of the form "run_{taskname}_example1.sh" which runs
the task in isolation against a data file in the example_data/ directory. These
scripts rely on miniwdl and docker to be installed as described in Installation above.

For example:

    bash run_pyclone_vi_example1.sh

will run pyclone-vi to cluster the mutations per sample in the input synthetic.tsv
file. This will create the miniwdl output in the runs/ directory:

     $ tree runs/_LAST
     runs/_LAST
     ├── command
     ├── inputs.json
     ├── out
     │   ├── cluster_assignment
     │   │   └── cluster_assignment.tsv -> ../../work/cluster_assignment.tsv
     │   ├── err_response
     │   │   └── stderr.txt -> ../../stderr.txt
     │   └── response
     │       └── stdout.txt -> ../../stdout.txt
     ├── outputs.json
     ├── rerun
     ├── stderr.txt
     ├── stdout.txt
     ├── task.log
     ├── wdl
     │   └── pyclone-vi-task.wdl
     └── work
         ├── _miniwdl_inputs
             │   └── 0
                 │       └── synthetic.tsv
                     ├── cluster_assignment.tsv
                         └── cluster_fit.hdf5

                         8 directories, 14 files



## Workflow Example

A full example of running the vcf_to\_clusters workflow can found in run\_workflows_example1.sh

    bash run_workflow_example1.sh

This will run the full workflow with the same example VCF as run_vcf_transform_example1.sh, but will pass the outputs
to the downstream clustering algorithms pyclone and pyclone-vi.


When complete, the output directory structures will look like:

## References

Workflow Description Language (WDL)
