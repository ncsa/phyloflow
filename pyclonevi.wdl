# Workflow for running pyclone-vi against it's sample data passed in.
# TODO: add vcf translation task before the pyclone task.
version 1.0

task vcf_to_pyclonevi_format{
    input {
		File vcf_input_file
		File tsv_sample
		String vcf_type #basically pipeline name that produced it
    	}

	command {
		echo "currently this is a noop" >> pyclone_vi_formatted.tsv
		}

	output {
		File response = stdout()
		File err_response = stderr()
		File pyclone_vi_formatted = 'pyclone_vi_formatted.tsv'
		File tsv_sample
		}

	runtime {
		docker: 'phyloflow/pyclone:latest'
		}
}

task pyclone_vi_clustering{
    input {
		File pyclone_vi_formatted
    }

	command {
		sh /code/pyclone_vi_entrypoint.sh
		}

	output {
		File response = stdout()
		File err_response = stderr()
		File captured_pyclonevi_help= 'pyclonevi_help.txt'
		}

	runtime {
		docker: 'phyloflow/pyclone:latest'
		}
}

workflow pyclone_vi{
    call  vcf_to_pyclonevi_format {
		input:
			vcf_input_file = vcf_input_file #a File
	}
    call  pyclone_vi_clustering {
		input:
			pyclone_vi_tsv = vcf_to_pyclone_vi_format.pyclone_vi_format
			pyclone_vi_tsv_sample = tsv_for_now
	}
}

