
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
		#File clusters = 'clusters_from_sample.yml'

		Array[File] outputs = glob("*.yaml")
		}

	runtime {
		docker: 'phyloflow/pyclone:latest'
		}
}
