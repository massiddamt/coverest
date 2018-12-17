def get_path(wildcards,samples,header='bamlist'):
    return samples.loc[wildcards.sample,
                     [header]].dropna()[0]

rule bbmap:
    input:
        lambda wildcards: get_path(wildcards, samples, 'bamlist')

    output:
       covstats = "cov/bbmap/{sample}.bbmap.covstats.txt",
       hist = "cov/bbmap/{sample}.bbmap.hist.txt",
       bincov = "cov/bbmap/{sample}.bbmap.bincov.txt"

    params:
        config.get("rules").get("bbmap").get("params")

    log:
        "logs/bbmap/{sample}.bbmap_coverage_info.log"

    conda:
       "../envs/bbmap.yaml"

    threads: 5

    shell:
        "pileup.sh "
        "in={input} "
        "out={output.covstats} "
        "hist={output.hist} "
        "bincov={output.bincov} "
        "t={threads} "
        "{params} "
        ">& {log}"

