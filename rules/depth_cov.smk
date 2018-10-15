rule depth_coverage:
    input:
        expand("{sample.bamlist}", sample=bamlist.reset_index().itertuples())

    output:
        expand("reads/cov/{sample.sample}.depthOfCov.COUNT_READS", sample=samples.reset_index().itertuples())

    params:
        genome=resolve_single_filepath(*references_abs_path(), config.get("genome_fasta")),
        depth_coverage_config=config.get("rules").get("depth_coverage").get("params")

    log:
        expand("logs/gatk/DepthOfCoverage/{sample.sample}.coverage_info.log", sample=samples.reset_index().itertuples())

    threads: 4

    shell:
        "gatk -T DepthOfCoverage "
        "-R {params.genome} "
        "{params.depth_coverage_config} "
        "-I {input} "
        "-o {output} "
        ">& {log}"