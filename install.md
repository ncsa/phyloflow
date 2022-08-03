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
There are many ways to install the aws-cli which the ECR script use, but for
consistency here is the conda command:
```
conda install -c conda-forge awscli
```

### AWS Elastic Container Registry
Phyloflow uses the AWS docker hub alternative to publish the docker images used
by the pipeline stages. The only cost is the file storage to S3.

The public gallery (published images) is here: https://gallery.ecr.aws/?searchTerm=phyloflow
The private admin panels are in the uiuc-ncsa-visualanalytics account, eg:
https://us-east-1.console.aws.amazon.com/ecr/repositories/public/416927654161/phyloflow/cluster_transform?region=us-east-1

#### Publishing new image versions
The high level steps are:
1. Install AWS credentials on the local machine
2. Log into the docker registry using a script that calls AWS.
3. Run the publish-docker* script for each pipeline stage.


Credentials:

Standard usage is to get security credentials for the user `phyloflow-ecr-uploader`
https://us-east-1.console.aws.amazon.com/iam/home#/users/phyloflow-ecr-uploader

The credentials need to be under a profile `phyloflow` in ~/.aws/credentials
like this (you may already have a `default` profile, add this after):

       [phyloflow]
       aws_access_key_id = XXXX_your_key_for_phyloflow-ecr-uploader
       aws_secret_access_key = YYYY_your_secret_key_for_phyloflow-ecr-uploader

In theory you could also give your own account the same permissions that the phyloflow IAM user has.

If IAM permissions are working and you have the aws-cli installed, this command will list the public repositories.
```
aws ecr-public --profile phyloflow --region us-east-1  describe-repositories
```

If that command doesn't work, the scripts in this repo likely won't work.

With the credentials installed, you can now 'log in' to docker using the script:
```
sh login_docker_aws_ecr.sh
```

If you don't care to build the docker images yourself, you can pull them all:
```
sh pull_docker_images
```

Finally, if you want the image built on your local machine and then to be
published as the new publically available version, you can, for example:
```
cd vcf_transform/docker
sh build_vcf_transform_container.sh
sh publish_vcf_transform_container.sh latest
```

