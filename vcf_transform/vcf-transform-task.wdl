
task vcf_transform{
    input {
		File vcf_file
		String vcf_type #only 'mutect' currently supported
    }

	command {
		pwd
		out_dir=$(pwd)
		cd /code
		sh vcf_transform_entrypoint.sh ${vcf_type} ${vcf_file} $out_dir/headers_as_json.txt
		pwd
		ls -al
		cd ..
		ls -al /
		ls /mnt
	}

	output {
		File response = stdout()
		File err_response = stderr()
		File headers = 'headers_as_json.txt'

		#File clusters = 'tables/cluster.tsv'
		#File loci = 'tables/loci.tsv'
		}

	runtime {
		docker: 'phyloflow/vcf-transform:latest'
		}
}

