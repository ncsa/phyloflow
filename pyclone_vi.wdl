version 1.0

task pyclone_vi{
    input {
        String name
    }

command {
	echo 'hello ${name}!'
	sh /code/pyclone_entrypoint.sh
    }

output {
    File response = stdout()
    }

runtime {
    docker: 'hub.ncsa.illinois.edu/phyloflow/pyclone:latest' 
    }
}

workflow run_entrypoint {
    call  pyclone_vi
}

