# Phyloflow

Phylogenetic tree computations packaged with Docker and WDL.

This repo contains tools to package commandline tools from the field
of cancer phylogeny into workflow building blocks including:

- A Dockerfile for each individual computational tool.
- WDL task definitions that define the inputs and outputs of each tool (and use the docker container for execution)
- Scripts to push built Docker images to the NCSA-VISA docker repo (on AWS ECR) (needs api keys)
- Sample WDL workflows that contain the above tasks.
- Example scripts to run the workflows using miniwdl at the commandline, using example data from this repo.
- Integration configs for [Dockstore.org](https://www.dockstore.org/workflows/github.com/ncsa/phyloflow/phyloflow_standalone:master?tab=info)

This is currently a **_prototype_** and is meant to be a demonstration of WDL and
Docker to experiment with deployment options, not to produce fine-tuned results without additional QC.

## Combined Workflow: phyloflow_standalone

This repo currently contains the WDL tasks and workflow to:

1. Load a VCF file produced by 'mutect' and the annotated version of that file from VEP.
2. Transform the VCF's mutations into the input formats of 'pyclone-vi' as a task.
3. Run 'pyclone-vi' for mutation clustering.
4. Transform the pyclone clustering outputs to be compatible with 'spruce' tree inference.
5. Run 'spruce' tree inference.
6. Collect the appropriate output files and combine into a JSON file compatible with the visualization tool [PhyloDiver](https://github.com/ncsa/phylodiver-viz).

![standalone](dockstore/phyloflow_standalone_dag.PNG)

This combined workflow can be launched with several cloud platforms from the [Dockstore.org](https://www.dockstore.org/workflows/github.com/ncsa/phyloflow/phyloflow_standalone:master?tab=info) or locally after following the installation instructions below from the command line with:

        bash run_standalone_example1.sh

## Installation

Also see [install.md](install.md) for advanced docs

### Prereqs

- Example scripts require miniwdl 0.9. If you have conda installed:

        conda install miniwdl

- Requires docker installed on the local machine, with the current user in group 'docker'

### Docker images

The wdl tasks each have their own docker image that must be stored locally. You may either pull
the images from the NCSA's docker hub or build from Dockerfile's using the provided scripts.

To download and install from NCSA-VISA's hub, use the provided script:

    sh pull_docker_images.sh

OR to build the images yourself:

    cd ../../pyclone_vi/docker
    sh build_pyclone_vi_container.sh

    cd ../../vcf_transform/docker
    sh build_vcf_transform_container.sh

## Isolated Task Examples

Each WDL Task has a script of the form `run_{taskname}_example1.sh` which runs
the task in isolation against a data file in the `example_data/` directory. These
scripts rely on miniwdl and docker to be installed as described in Installation above.

For example:

    bash run_pyclone_vi_example1.sh

will run pyclone-vi to cluster the mutations per sample using `example_data/pyclone-vi/synthetic.tsv`
as the input mutations file. This will create the miniwdl output in the runs/ directory:

     $ tree runs/_LAST
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

## References

1. **Workflow Description Language (WDL)**: [[link](https://openwdl.org/)]
2. **Variant Effect Predictor (VEP)**: McLaren, et al. "The Ensembl Variant Effect Predictor". _Genome Biology_, 2016. [[link](https://uswest.ensembl.org/info/docs/tools/vep/index.html)]
3. **PyClone-VI**: Gillis and Roth. "PyClone-VI: scalable inference of clonal population structures using whole genome data." _BMC bioinformatics_, 2020. [[link](https://link.springer.com/article/10.1186/s12859-020-03919-2)]
4. **SPRUCE**: El-Kebir, et al. "Inferring the mutational history of a tumor using multi-state perfect phylogeny mixtures." _Cell systems_, 2016. [[link](https://www.sciencedirect.com/science/article/pii/S2405471216302216)]

## Workflow Example

A full example of running the `vcf_to_clusters` workflow can found in `run_workflows_example1.sh`

    bash run_workflow_example1.sh

This will run the full workflow with the same example VCF as `run_vcf_transform_example1.sh`, but will pass the outputs
to the downstream clustering algorithms pyclone and pyclone-vi.

WARNING: The pyclone step takes roughly an hour to complete.

When complete, the output directory structures will look like:

    $ tree runs/_LAST
    ├── call-step1
    │   ├── command
    │   ├── inputs.json
    │   ├── out
    │   │   ├── err_response
    │   │   │   └── stderr.txt -> ../../stderr.txt
    │   │   ├── headers_json
    │   │   │   └── headers.json -> ../../work/headers.json
    │   │   ├── mutations_json
    │   │   │   └── mutations.json -> ../../work/mutations.json
    │   │   ├── pyclone_formatted_tsvs
    │   │   │   └── 0
    │   │   │       └── A25.mutect2.tsv -> ../../../work/pyclone_samples/A25.mutect2.tsv
    │   │   ├── pyclone_vi_formatted_tsv
    │   │   │   └── pyclone_vi_formatted.tsv -> ../../work/pyclone_vi_formatted.tsv
    │   │   └── response
    │   │       └── stdout.txt -> ../../stdout.txt
    │   ├── outputs.json
    │   ├── stderr.txt
    │   ├── stdout.txt
    │   ├── task.log
    │   └── work
    │       ├── _miniwdl_inputs
    │       │   └── 0
    │       │       └── A25.mutect2.vcf
    │       ├── headers.json
    │       ├── mutations.json
    │       ├── pyclone_samples
    │       │   └── A25.mutect2.tsv
    │       └── pyclone_vi_formatted.tsv
    ├── call-step2
    │   ├── command
    │   ├── inputs.json
    │   ├── out
    │   │   ├── clusters
    │   │   │   └── cluster.tsv -> ../../work/tables/cluster.tsv
    │   │   ├── err_response
    │   │   │   └── stderr.txt -> ../../stderr.txt
    │   │   ├── loci
    │   │   │   └── loci.tsv -> ../../work/tables/loci.tsv
    │   │   └── response
    │   │       └── stdout.txt -> ../../stdout.txt
    │   ├── outputs.json
    │   ├── stderr.txt
    │   ├── stdout.txt
    │   ├── task.log
    │   └── work
    │       ├── _miniwdl_inputs
    │       │   └── 0
    │       │       └── A25.mutect2.tsv
    │       ├── config.yaml
    │       ├── plots
    │       │   └── cluster
    │       ├── tables
    │       │   ├── cluster.tsv
    │       │   └── loci.tsv
    │       ├── trace
    │       │   ├── A25.mutect2.cellular_prevalence.tsv.bz2
    │       │   ├── alpha.tsv.bz2
    │       │   ├── labels.tsv.bz2
    │       │   └── precision.tsv.bz2
    │       └── yaml
    │           └── A25.mutect2.yaml
    ├── call-step3
    │   ├── command
    │   ├── inputs.json
    │   ├── out
    │   │   ├── cluster_assignment
    │   │   │   └── cluster_assignment.tsv -> ../../work/cluster_assignment.tsv
    │   │   ├── err_response
    │   │   │   └── stderr.txt -> ../../stderr.txt
    │   │   └── response
    │   │       └── stdout.txt -> ../../stdout.txt
    │   ├── outputs.json
    │   ├── stderr.txt
    │   ├── stdout.txt
    │   ├── task.log
    │   └── work
    │       ├── _miniwdl_inputs
    │       │   └── 0
    │       │       └── pyclone_vi_formatted.tsv
    │       ├── cluster_assignment.tsv
    │       └── cluster_fit.hdf5
    ├── inputs.json
    ├── out
    │   ├── pyclone_clusters
    │   │   └── loci.tsv -> ../../call-step2/work/tables/loci.tsv
    │   └── pyclone_vi_clusters
    │       └── cluster_assignment.tsv -> ../../call-step3/work/cluster_assignment.tsv
    ├── outputs.json
    ├── rerun
    ├── wdl
    │   ├── pyclone
    │   │   └── pyclone-task.wdl
    │   ├── pyclone_vi
    │   │   └── pyclone-vi-task.wdl
    │   ├── vcf_transform
    │   │   └── vcf-transform-task.wdl
    │   └── workflows
    │       └── vcf_to_clusters.wdl
    └── workflow.log

    43 directories, 58 files
