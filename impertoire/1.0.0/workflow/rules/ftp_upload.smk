rule ftp_upload:
	input:
		# trust4
		trust4_final_out = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_final.out",
		trust4_annot_fa = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_annot.fa",
		trust4_report = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_report.tsv",
		trust4_cdr3_out = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_cdr3.out",
		trust4_airr = config["analysis_dir"] + "results/trust4/{sample_name}/{sample_name}_airr.tsv",
		# star
		star_final_log = config["analysis_dir"] + "results/star/{sample_name}/Log.final.out",
		star_bam = config["analysis_dir"] + "results/star/{sample_name}/Aligned.sortedByCoord.out.bam",
	output:
		# trust4
		trust4_final_out = config["analysis_dir"] + "results/ftp_upload/trust4/{sample_name}/{sample_name}_final.out",
		trust4_annot_fa = config["analysis_dir"] + "results/ftp_upload/trust4/{sample_name}/{sample_name}_annot.fa",
		trust4_report = config["analysis_dir"] + "results/ftp_upload/trust4/{sample_name}/{sample_name}_report.tsv",
		trust4_cdr3_out = config["analysis_dir"] + "results/ftp_upload/trust4/{sample_name}/{sample_name}_cdr3.out",
		trust4_airr = config["analysis_dir"] + "results/ftp_upload/trust4/{sample_name}/{sample_name}_airr.tsv",
		# star
		star_final_log = config["analysis_dir"] + "results/ftp_upload/star/{sample_name}/Log.final.out",
		star_bam = config["analysis_dir"] + "results/ftp_upload/star/{sample_name}/Aligned.sortedByCoord.out.bam",
	params:
		sample_name = lambda wildcards: samples.loc[wildcards.sample_name, 'sample_name'],
		anal_dir = config["analysis_dir"] + "results/star/{sample_name}/",
		star_genome_dir = lambda wildcards: samples.loc[wildcards.sample_name, 'star_genome_dir'],
	log:
		stdout = config["analysis_dir"] + "log/ftp_upload/{sample_name}.stdout.txt",
		stderr = config["analysis_dir"] + "log/ftp_upload/{sample_name}.stderr.txt",
	benchmark: "benchmark/ftp_upload/{sample_name}.txt"
	shell:
		"ln -s {input.trust4_final_out} {output.trust4_final_out}\n"
		"ln -s {input.trust4_annot_fa} {output.trust4_annot_fa}\n"
		"ln -s {input.trust4_report} {output.trust4_report}\n"
		"ln -s {input.trust4_cdr3_out} {output.trust4_cdr3_out}\n"
		"ln -s {input.trust4_airr} {output.trust4_airr}\n"
		"ln -s {input.star_final_log} {output.star_final_log}\n"
		"ln -s {input.star_bam} {output.star_bam}\n"
