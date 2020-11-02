# Prints help messages from pyclone and pyclone-vi packages. 
# Proves that you have the docker image and the pyclone* installs
# inside them are working.

version 1.0

task pyclone_help{
    input {
    	}

	command {
		sh /code/pyclone_entrypoint.sh
		}

	output {
		File response = stdout()
		File err_response = stderr()
		File captured_PyClone_help= 'PyClone_help.txt'
		}

	runtime {
		docker: 'phyloflow/pyclone:latest'
		}
}

task pyclone_vi_help{
    input {
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

workflow run_entrypoint {
    call  pyclone_vi_help
    call  pyclone_help
}

