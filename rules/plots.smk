
rule plot_bbmap_coverage:
    input:
        "cov/bbmap/"
    output:
        report("cov/plots/bbmap_coverage.png", caption="../report/bbmap_coverage.rst", category="BBMAP"),
        report("cov/plots/summary/bbmap_coverage_summary.tsv", caption="../report/bbmap_coverage.rst",category="BBMAP")
    script:
        "../scripts/bbmap_coverage.R"



rule plot_depthofcoverage:
    input:
        "cov/"
    output:
        report("cov/plots/gatk_coverage.png", caption="../report/gatk_coverage.rst", category="GATK"),
        report("cov/plots/summary/gatk_coverage_summary.tsv", caption="../report/gatk_coverage.rst",category="GATK")
    script:
        "../scripts/depthofcoverage.R"
