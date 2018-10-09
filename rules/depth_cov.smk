rule depth_coverage:
    input:
        bamlist = os.listdir(config.get("paths").get("to_sample"))
    output:
        expand("coverage/{sample.sample}.depthOfCov.COUNT_READS", sample=samples.reset_index().itertuples())

    params:
#        genome=resolve_single_filepath(*references_abs_path(), config.get("genome_fasta")),
        genome="/ELS/els9/users/biosciences/references/oar_ref_Oar_v4.0_fixChr.fa",
        depth_coverage_config=config.get("rules").get("depth_coverage").get("params")
    log:
        "logs/gatk/DepthOfCoverage/{sample.sample}.coverage_info.log"
    threads: 4
    shell:
        "gatk -T DepthOfCoverage "
        "-R {params.genome} "
        "{params.depth_coverage_config} "
        "-I {input.bamlist} "
        "-O {output} "
        ">& {log}"




