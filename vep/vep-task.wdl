workflow run_vep {
    call vep
}

task vep{
    String ref # GRCh37 or GRCh38
    File cache_dir # path to location of cache files
    String cache_version = "104"
    File vcf

    String outprefix = basename(vcf, '.vcf')
    String outfname = "VEP_raw.${outprefix}.vcf"
    command {
        pwd
        ls -al
        echo "## extracting and localizing cache directory"
        echo ${outprefix}
        echo ${outfname}

        tar -tvf ${cache_dir}
        tar -xf ${cache_dir} -C ~/
        CACHE_PATH=$(cd ~/${basename(cache_dir, '.tar')}; pwd)
        echo "## success; see cache directory -- "$CACHE_PATH

        /opt/vep/src/ensembl-vep/vep \
        --cache \
        --dir_cache "$CACHE_PATH" \
        --cache_version ${cache_version} \
        --offline \
        --fork 4 \
        --format vcf \
        --vcf \
        --assembly ${ref} \
        --input_file ${vcf} \
        --output_file ${outfname} \
        --no_stats \
        --pick \
        --symbol \
        --canonical \
        --biotype \
        --max_af


        rm -rf ${cache_dir}
        rm -rf $CACHE_PATH
    }
    runtime {
        docker: 'ensemblorg/ensembl-vep:latest'
    }
    output {
        File response = stdout()
        File err_response = stderr()
        File vep_out = "${outfname}"
    }
}

