rule star:
	input:
		fastq_1 = lambda wildcards: samples.loc[wildcards.sample_name, 'fastq_1'],
		fastq_2 = lambda wildcards: samples.loc[wildcards.sample_name, 'fastq_2'],
	output:
		bam = config["analysis_dir"] + "results/star/{sample_name}/Aligned.sortedByCoord.out.bam",
		log_final = config["analysis_dir"] + "results/star/{sample_name}/Log.final.out",
	params:
		sample_name = lambda wildcards: samples.loc[wildcards.sample_name, 'sample_name'],
		anal_dir = config["analysis_dir"] + "results/star/{sample_name}/",
		star_genome_dir = lambda wildcards: samples.loc[wildcards.sample_name, 'star_genome_dir'],
	log:
		stdout = config["analysis_dir"] + "log/star/{sample_name}.stdout.txt",
		stderr = config["analysis_dir"] + "log/star/{sample_name}.stderr.txt",
	benchmark: "benchmark/star/{sample_name}.txt"
	container: config["tools"]["star"]
	shell:
		"STAR --runMode alignReads --runThreadN 8 --genomeDir {params.star_genome_dir} --readFilesIn {input.fastq_1} {input.fastq_2}  --outFileNamePrefix {params.anal_dir} --outSAMtype BAM Unsorted SortedByCoordinate --outFilterMatchNmin 0 --outFilterScoreMinOverLread 0.0 --outFilterMatchNminOverLread 0.0 1> {log.stdout} 2> {log.stderr}"
