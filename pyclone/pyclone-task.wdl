
task pyclone_clustering{
    input {
		Array[File] tsv_sample_files 
    }

	command {
		sh /code/pyclone_entrypoint.sh ${sep=' ' tsv_sample_files}
	}

	output {
		File response = stdout()
		File err_response = stderr()

		#Array[File] outputs = glob("*.yaml")
		File clusters = 'tables/cluster.tsv'
		File loci = 'tables/loci.tsv'
		}

	runtime {
		docker: 'phyloflow/pyclone:latest'
		}
}
