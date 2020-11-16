version 1.0

import "../vcf_transform/vcf-transform-task.wdl" as vcf_transform_task
#
#task vcf_to_pyclonevi_format{
#    input {
#		File vcf_input_file
#		String vcf_type #basically pipeline name that produced it, ['mutect', 'strelka', etc]
#    	}
#
#	command {
#		echo "currently this is a noop for type: ${vcf_type}" >> pyclone_vi_formatted.tsv
#
#		#copy the sample tsv (already formatted) to outputs without modifiying
#		cp ${tsv_sample} passthrough_sample.tsv 
#		cp ${vcf_input_file} pyclone_vi_formatted.tsv
#		}
#
#	output {
#		File response = stdout()
#		File err_response = stderr()
#		File tsv_for_pyclone_vi = 'pyclone_vi_formatted.tsv'
#		File sample_tsv_for_pyclone_vi = "passthrough_sample.tsv"
#		}
#
#	runtime {
#		docker: 'phyloflow/pyclone:latest'
#		}
#}
#
#task pyclone_vi_clustering{
#    input {
#		File tsv_for_pyclone_vi
#		File sample_tsv_for_pyclone_vi
#    }
#
#	command {
#		sh /code/pyclone_vi_entrypoint.sh
#		cp ${tsv_for_pyclone_vi} clusters_from_vcf.tsv
#		cp ${sample_tsv_for_pyclone_vi} clusters_from_tsv_sample.tsv
#		}
#
#	output {
#		File response = stdout()
#		File err_response = stderr()
#		File captured_pyclonevi_help = 'pyclonevi_help.txt'
#		File clusters_from_vcf = 'clusters_from_vcf.tsv'
#		File clusters_from_tsv_sample = 'clusters_from_tsv_sample.tsv'
#		}
#
#	runtime {
#		docker: 'phyloflow/pyclone:latest'
#		}
#}
#

workflow vcf_to_clusters{
	input {

		File vcf_input_file
		String vcf_type

	}
    call  vcf_transform_task as step1 {
		input:
			vcf_file = vcf_input_file,
			vcf_type = vcf_type,

	}
#    call  pyclone_vi_clustering as step2{
#		input:
#			tsv_for_pyclone_vi = step1.tsv_for_pyclone_vi,
#			sample_tsv_for_pyclone_vi = step1.sample_tsv_for_pyclone_vi
#	}
#    call  pyclone_clustering as step3{
#		input:
#			tsv_for_pyclone_vi = step1.tsv_for_pyclone_vi,
#			sample_tsv_for_pyclone_vi = step1.sample_tsv_for_pyclone_vi
#	}
#	output {
#
#
#	}

}

