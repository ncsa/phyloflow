version 1.0

import "../cluster_transform/cluster-transform-task.wdl" as cluster_transform_task
import "../spruce/spruce-task.wdl" as spruce_task

# workflow to construct trees from clusters
workflow clusters_to_trees{

	input {

		File cluster_tsv
		String cluster_type
		Float alpha
		File? pyclone_vi_formatted

	}

	call cluster_transform_task.cluster_transform as step1 {
		input:
			cluster_tsv_file = cluster_tsv,
			cluster_type = cluster_type,
			alpha = alpha,
			pyclone_vi_formatted = if (defined(pyclone_vi_formatted)) then pyclone_vi_formatted else ""
	}

	call spruce_task.spruce_phylogeny as step2 {
		input:
			tsv_data_file = step1.spruce_input
	}

	output {
		File cliques = step2.cliques
		File result = step2.result
		File rank_result = step2.rank_result
	}

}

