
task spruce_phylogeny {
	input {
		File tsv_data_file
    }

	command {
		sh /code/spruce_entrypoint.sh ${tsv_data_file}
	}

	output {
		File response = stdout()
		File err_response = stderr()

		File cliques = "spruce.cliques"
		File result = "spruce.res.gz"
		File rank_result = "spruce.merged.res"
	}

	runtime {
		docker: 'phyloflow/spruce:latest'
	}
}
