rule test:
	input:
		fastq_1 = lambda wildcards: samples.loc[wildcards.sample_name, 'fastq_1'],
		fastq_2 = lambda wildcards: samples.loc[wildcards.sample_name, 'fastq_2'],
	output:
		test = config["analysis_dir"] + "results/test/{sample_name}/test.txt",
	params:
		db = config['database']['trust4']['mm10'],
		#output_dir = config["analysis_dir"] + "results/virulencefinder/{sample_name}/",
	log:
		stdout = config["analysis_dir"] + "log/test/{sample_name}.stdout.txt",
		stderr = config["analysis_dir"] + "log/test/{sample_name}.stderr.txt",
	benchmark: "benchmark/test/{sample_name}.txt"
	container: config["tools"]["trust4"]
	shell: 
		"echo {input.fastq_1} {input.fastq_2} {params.db} 1> {output.test} 2> {log.stderr}"


rule trust4:
	input:
		fastq_1 = lambda wildcards: samples.loc[wildcards.sample_name, 'fastq_1'],
		fastq_2 = lambda wildcards: samples.loc[wildcards.sample_name, 'fastq_2'],
	output:
		trust4_final_out = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_final.out",
		trust4_annot_fa = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_annot.fa",
		trust4_report = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_report.tsv",
		trust4_cdr3_out = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_cdr3.out",
		trust4_airr = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_airr.tsv",
	params:
		sample_name = lambda wildcards: samples.loc[wildcards.sample_name, 'sample_name'],
		anal_dir = config["analysis_dir"],
		trust4_fa = lambda wildcards: samples.loc[wildcards.sample_name, 'trust4_fa'],
		trust4_imgt = lambda wildcards: samples.loc[wildcards.sample_name, 'trust4_imgt'],
	log:
		stdout = config["analysis_dir"] + "log/trust4/{sample_name}.stdout.txt",
		stderr = config["analysis_dir"] + "log/trust4/{sample_name}.stderr.txt",
	benchmark: "benchmark/trust4/{sample_name}.txt"
	container: config["tools"]["trust4"]
	shell:
		"/usr/src/TRUST4/run-trust4 -1 {input.fastq_1} -2 {input.fastq_2} -f {params.trust4_fa} --ref {params.trust4_imgt} --od {params.anal_dir}results/trust4/{params.sample_name}/ -o {params.sample_name} -t 8 1> {log.stdout} 2> {log.stderr}"
