version 1.0

import "../vcf_transform/vcf-transform-task.wdl" as vcf_transform_task
import "../pyclone/pyclone-task.wdl" as pyclone_task
import "../pyclone_vi/pyclone-vi-task.wdl" as pyclone_vi_task

# workflow to load a vcf and transform it (step1) into the input formats
# needed by pyclone (step2) and pyclone-vi (step3) to produce mutation clusters
workflow vcf_to_clusters{

	input {

		File vcf_input_file
		String vcf_type

	}
    call  vcf_transform_task.vcf_transform as step1 {
		input:
			vcf_file = vcf_input_file,
			vcf_type = vcf_type
	}
	
	call pyclone_task.pyclone_clustering as step2 {
		input:
			tsv_sample_files = step1.pyclone_formatted_tsvs
	}

	call pyclone_vi_task.pyclone_vi_clustering as step3{
		input:
			mutations_tsv = step1.pyclone_vi_formatted_tsv
	}
	output {
		File pyclone_clusters = step2.loci
		File pyclone_vi_clusters = step3.cluster_assignment
		}
			
}

