rule active_gatk:
    output:
        touch("gatk_activation.done")

    params:
        config.get("paths").get("to_gatk")

    conda:
        "../envs/gatk.yaml"
    shell:
        "gatk-register {params}/GenomeAnalysisToolkit.jar "



def get_path(wildcards,samples,header='bamlist'):
    return samples.loc[wildcards.sample,
                     [header]].dropna()[0]

rule depth_coverage:
    input:
        lambda wildcards: get_path(wildcards, samples, 'bamlist'),
        "gatk_activation.done"

    output:
       "cov/{sample}.depthOfCov.COUNT_READS.sample_summary"

    params:
        genome=resolve_single_filepath(*references_abs_path(), config.get("genome_fasta")),
        depth_coverage_config=config.get("rules").get("depth_coverage").get("params")

    log:
        "logs/gatk/DepthOfCoverage/{sample}.coverage_info.log"

    conda:
       "../envs/gatk.yaml"

    threads: 5

    run:
        file_basename = '.'.join(output[0].split('.')[0:3])
        shell(
            "gatk -T DepthOfCoverage "
            "-R {params.genome} "
            "{params.depth_coverage_config} "
            "-I {input} "
            "-o {file_basename} "
            "-nt {threads} "
            ">& {log} ")