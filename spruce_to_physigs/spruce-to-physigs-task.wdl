task spruce_to_physigs_transform{
    input {
        File tsv_variants
        File json_edge_list
    }

    command {
        pwd
        mkdir pyclone_samples
        out_dir=$(pwd)
        cd /code
        sh spruce_to_physigs_entrypoint.sh ${tsv_variants} ${json_edge_list} $out_dir/physigs
        pwd
        ls -al
        cd ..
        ls -al /
        ls /mnt
    }

    output {
        File response = stdout()
        File err_response = stderr()

        File tree_csv = "physigs.tree.csv"
        File snvs_csv = "physigs.snv.csv"
    }

    runtime {
        docker: 'phyloflow/spruce-to-physigs:latest'
    }
}

