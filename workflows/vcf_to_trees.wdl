version 1.0

import "../vcf_transform/vcf-transform-task.wdl" as vcf_transform_task
import "../pyclone_vi/pyclone-vi-task.wdl" as pyclone_vi_task
import "../cluster_transform/cluster-transform-task.wdl" as cluster_transform_task
import "../spruce/spruce-task.wdl" as spruce_task
import "../spruce_to_physigs/spruce-to-physigs-task.wdl" as transform_task
import "../physigs/physigs-task.wdl" as physigs_task

# workflow to construct trees from clusters vcf files
workflow vcf_to_trees{

    input {
        File vcf_input_file
        String vcf_type
        Float alpha
        File? signatures
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

    call cluster_transform_task.cluster_transform as step3 {
        input:
            cluster_tsv_file = step2.cluster_assignment,
            cluster_type = "pyclone-vi",
            alpha = alpha,
            pyclone_vi_formatted = step1.pyclone_vi_formatted_tsv
    }

    call spruce_task.spruce_phylogeny as step4 {
        input:
            tsv_data_file = step3.spruce_input
    }


    call transform_task.spruce_to_physigs_transform as step5 {
        input:
            tsv_variants=step2.cluster_assignment,
            json_edge_list=step4.tree_json,
    }

    call physigs_task.physigs as step6 {
        input:
            tree_csv = step5.tree_csv,
            snvs_csv = step5.snvs_csv,
            signatures = signatures
    }

    output {
        File cliques = step4.cliques
        File result = step4.result
        File rank_result = step4.rank_result
        File tree_text = step4.tree_text
        File tree_json = step4.tree_json
        File physigs_plot = step6.physigs_plot
        File physigs_tree = step6.physigs_tree
        File physigs_exposure = step6.physigs_exposure
    }

}

