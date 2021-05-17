task physigs{
	input {
		File tree_csv
		File snv_csv
		File? signatures
	}

	command {
		pwd
		out_dir=$(pwd)
		cd /code
		sh physigs_entrypoint.sh ${tree_csv} ${snv_csv} $out_dir/physigs_tree \
			${if defined(signatures) then signatures else "" }
		pwd
		ls -al
		cd ..
		ls -al /
		ls /mnt
	}

	output {
		File response = stdout()
		File err_response = stderr()

		File physigs_plot = 'physigs_tree.plot.pdf'
		File physigs_tree = 'physigs_tree.tree.tsv'
		File physigs_exposure = 'physigs_tree.exposure.tsv'


		}

	runtime {
		docker: 'phyloflow/physigs:latest'
		}
}

