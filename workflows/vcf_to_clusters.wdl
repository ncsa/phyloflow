version 1.0

import "../vcf_transform/vcf-transform-task.wdl" as vcf_transform_task
import "../pyclone_vi/pyclone-vi-task.wdl" as pyclone_vi_task

# workflow to load a vcf and transform it (step1) into the input formats
# needed by  pyclone-vi (step2) to produce mutation clusters
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
	
	call pyclone_vi_task.pyclone_vi_clustering as step2 {
		input:
			mutations_tsv = step1.pyclone_vi_formatted_tsv
	}
	output {
		File pyclone_vi_clusters = step2.cluster_assignment
		}
			
}

