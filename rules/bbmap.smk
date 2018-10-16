def get_path(wildcards,samples,header='bamlist'):
    return samples.loc[wildcards.sample,
                     [header]].dropna()[0]

rule bbmap:
    input:
        lambda wildcards: get_path(wildcards, samples, 'bamlist')

    output:
       covstats = "reads/cov/bbmap/{sample}.bbmap.covstats.txt",
       hist = "reads/cov/bbmap/{sample}.bbmap.hist.txt",
       bincov = "reads/cov/bbmap/{sample}.bbmap.bincov.txt"

    params:
        config.get("rules").get("bbmap").get("params")

    log:
        "logs/bbmap/{sample}.bbmap_coverage_info.log"

    threads: 5

    shell:
        "pileup.sh "
        "in = {input} "
        "out = {output.covstats} "
        "hist = {output.hist} "
        "bincov = {output.bincov} "
        "{params} "
        ">& {log}"
