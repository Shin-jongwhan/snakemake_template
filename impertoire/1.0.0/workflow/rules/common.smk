import pandas as pd
import numpy as np
import os
from snakemake.utils import validate

#validate(config, schema="../schemas/config.schema.yaml")

from pathlib import Path

result_path = (config["analysis_dir"] + "/results").replace("//", "/")

samples = (
	pd.read_csv(config["samples"], sep="\t", dtype={"TNID": str, "sample_name": str }, comment='#')
	.set_index("sample_name", drop=False)
	.sort_index()
)

# option example
## You can add option sample by sample
#samples['res_input_type'] = np.where( samples["fastq"].values != "none", "ifq", "ifa")
#samples['vir_input'] = np.where( samples["fastq"].values != "none", samples["fastq"].values, samples["fasta"].values)
#samples['plasmidfinder_input'] = np.where( samples["fastq"].values != "none", samples["fastq"].values, samples["fasta"].values)
#samples['VF_input_type'] = np.where( samples["fasta_type"].values == "protein", "protein", "nucleotide")
#samples['VFDB'] = np.where( samples["fasta_type"].values == "protein", config["database"]["virulence_factor"]["protein"], config["database"]["virulence_factor"]["nucleotide"])

# option
samples['trust4_fa'] = ""		# init
samples['trust4_imgt'] = ""		# init
#samples['star_genome_dir'] = ""
for i in range(0, len(samples['trust4_reference'])) : 
	samples['trust4_fa'].iloc[i] = config['database']['trust4'][ samples['trust4_reference'].iloc[i] ]['fa']
	samples['trust4_imgt'].iloc[i] = config['database']['trust4'][ samples['trust4_reference'].iloc[i] ]['imgt']
	samples['star_genome_dir'].iloc[i] = config['database']['star']['genome_dir'][ samples['star_genome_dir'].iloc[i] ]

print(samples)


def read_tsv_file(sFile) : 
	f = open(sFile, 'r')
	ls = f.read().split("\n")
	for i in range(len(ls) - 1, -1, -1) : 
		if ls[i] == "" : 
			del ls[i]
			continue
		ls[i] = ls[i].split("\t")

	return ls

print(samples)

def get_final_output():
	result=[] 
	for sample_name in samples.index: 
		# test
		result.append(f"{result_path}/test/{sample_name}/test.txt")

		# trust4
		result.append(f"{result_path}/trust4/{sample_name}/{sample_name}_final.out")
		result.append(f"{result_path}/trust4/{sample_name}/{sample_name}_annot.fa")
		result.append(f"{result_path}/trust4/{sample_name}/{sample_name}_report.tsv")
		result.append(f"{result_path}/trust4/{sample_name}/{sample_name}_cdr3.out")
		result.append(f"{result_path}/trust4/{sample_name}/{sample_name}_airr.tsv")

		# star
		result.append(f"{result_path}/star/{sample_name}/Aligned.sortedByCoord.out.bam")
		result.append(f"{result_path}/star/{sample_name}/Log.final.out")

		# ftp upload
		result.append(f"{result_path}/ftp_upload/trust4/{sample_name}/{sample_name}_final.out")
		result.append(f"{result_path}/ftp_upload/trust4/{sample_name}/{sample_name}_annot.fa")
		result.append(f"{result_path}/ftp_upload/trust4/{sample_name}/{sample_name}_report.tsv")
		result.append(f"{result_path}/ftp_upload/trust4/{sample_name}/{sample_name}_cdr3.out")
		result.append(f"{result_path}/ftp_upload/trust4/{sample_name}/{sample_name}_airr.tsv")
		result.append(f"{result_path}/ftp_upload/star/{sample_name}/Aligned.sortedByCoord.out.bam")
		result.append(f"{result_path}/ftp_upload/star/{sample_name}/Log.final.out")
		
	print("result", result)
	return result


