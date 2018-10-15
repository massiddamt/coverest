def get_path(wildcards,samples,header='bamlist'):
    return samples.loc[wildcards.sample,
                     [header]].dropna()[0]

rule depth_coverage:
    input:
        lambda wildcards: get_path(wildcards, samples, 'bamlist')
        #expand("{sample.bamlist}", sample=bamlist.reset_index().itertuples())

    output:
       "reads/cov/{sample}.depthOfCov.COUNT_READS.sample_summary"
       "reads/cov/{sample}.depthOfCov.COUNT_READS.sample_statistics"

    params:
        genome=resolve_single_filepath(*references_abs_path(), config.get("genome_fasta")),
        depth_coverage_config=config.get("rules").get("depth_coverage").get("params")

    log:
        "logs/gatk/DepthOfCoverage/{sample}.coverage_info.log"

    threads: 4

    shell:
        "gatk -T DepthOfCoverage "
        "-R {params.genome} "
        "{params.depth_coverage_config} "
        "-I {input} "
        "-o {output} "
        ">& {log}"