def get_path(wildcards,samples,header='bamlist'):
    return samples.loc[wildcards.sample,
                     [header]].dropna()[0]

rule qualimap:
    input:
        lambda wildcards: get_path(wildcards, samples, 'bamlist')

    output:
        "cov/qualimap/{sample}/report.pdf"

    params:
        outdir = "cov/qualimap/{sample}",
        params = config.get("rules").get("qualimap").get("params"),
        outformat = config.get("rules").get("qualimap").get("outformat")

    log:
        "logs/qualimap/{sample}.qualimap_coverage_info.log"

    conda:
       "../envs/qualimap.yaml"

    threads: 5

    shell:
        "qualimap bamqc "
        "-bam {input} "
        "-outdir {params.outdir} "
        "{params.params} "
        "-outformat {params.outformat} "
        "-nt {threads} "
        ">& {log}"