## Install conda and miniwdl as a local user


### Conda
```
wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.3-Linux-x86_64.sh  -O ~/miniconda.sh
/bin/bash ~/miniconda.sh -b -p ~/opt/conda
echo ". ~/opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
```

### New env with Miniwdl

```
conda create -n phyloflow
conda activate phyloflow
conda install -c conda-forge miniwdl
```

### Pull and prepare existing docker images
```
sh pull_docker_images.sh
```

### Verify installation
This should now run and create an output
```
sh run_pyclone_vi_example1.sh
```

### Dockstore

The Dockstore CLI equires java 11, we can install via conda to keep things isolated
```
conda activate phyloflow
conda install -c conda-forge openjdk
java --version
```
Should say something about OpenJDK 11.X

For a normal install of dockstore for the current linux user, see https://dockstore.org/quick-start.

Here is how to install dockstore into the conda env created above:
TODO: this would be much if there was a conda package of dockstore
```
curl -L -o ~/opt/dockstore https://github.com/dockstore/dockstore/releases/download/1.10.2/dockstore
chmod u+x ~/opt/dockstore
echo 'export PATH=~/opt/dockstore:$PATH' >> ~/.bashrc
source ~/.bashrc
```

Now run dockstore for the first time to create a config file. You should register through the website first.
Refer to the quickstart page for values to input:https://dockstore.org/quick-start. 

This creates some files in `~/.dockstore/`. TODO: I would prefer these files be in the conda env.

```
dockstore tool launch --local-entry workflows/vcf_to_clusters.wdl --json dockstore/vcf_to_clusters_example1.test.json
```


### AWS
There are many ways to install the aws-cli, but for consistency here is the conda command:
```
conda install -c conda-forge awscli
```

If IAM permissions are working, this command will list the public repositories.
```
aws ecr-public --profile phyloflow --region us-east-1  describe-repositories
```


