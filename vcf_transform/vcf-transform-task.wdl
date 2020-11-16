
task vcf_transform{
    input {
		File vcf_file
		String vcf_type #only 'mutect' currently supported
    }

	command {
		cd /code
		sh vcf_transform_entrypoint.sh ${vcf_type} ${vcf_file} 
	}

	output {
		File response = stdout()
		File err_response = stderr()

		#File clusters = 'tables/cluster.tsv'
		#File loci = 'tables/loci.tsv'
		}

	runtime {
		docker: 'phyloflow/vcf-transform:latest'
		}
}

