# peline to analyze resistnace, virulence, horizontal gene transfer
### 1.0.0
### <br/><br/><br/>

## 파이프라인 설명
###
### <br/>

### 분석 항목
### 다음 항목에 대해서 분석할 수 있습니다.
- test
### <br/>

### 파이프라인 특징
-
### <br/><br/><br/>

## star build
### basic
```
STAR --runThreadN {threads} --runMode genomeGenerate"
         " --genomeDir {params.stargenomedir}"
         " --genomeFastaFiles {input.genome}"
         " --sjdbGTFfile {input.geneset}"
         " --limitGenomeGenerateRAM {config[params_star_limitGenomeGenerateRAM]}"
```
### <br/>

### without tgf ex)
```
STAR --runThreadN 32 --runMode genomeGenerate --genomeDir /TBI/People/tbi/jhshin/pipeline/TRUST4/test/star_build/ --genomeFastaFiles /TBI/People/tbi/jhshin/pipeline/TRUST4/TRUST4-1.0.13/mouse/GRCm38_bcrtcr.fa --limitGenomeGenerateRAM 32000000000 --genomeSAindexNbases 12
```

## Usage
### config/samples.tsv 작성
```
# fasta : input which is fasta format
#
# fasta_type
## contig (if input format is fasta, then type contig)
## protein (if input format is fsa (protein sequence), then type protein)
#
# taxon
## for resfinder
## You can check on [resfinder - db_resfinder dir]/phenotype_panels.txt or [resfinder - db_pointfinder dir]/config. This db dir is specified in config.yaml of this pipeline.
#
# fastq
## you can type none or fastq path
## res finder supports input both fasta and fastq format
## if fastq column is none, then it refer fasta column. if fastq file is given, it refer fastq column.
#
# that you may wonder
# virulence
## input : virulence read first line of input file. If the line has '@', then it presume as fastq. It has '>', then it presume as fasta. As same way, this pipeline get input to fasta if fastq is none
TNID    sample_name fasta   fasta_type  taxon   fastq
test    test    /TBI/People/tbi/jhshin/script/revi_gene/test/rgi_test_sample.fsa    protein Escherichia coli    none test2   test2   /TBI/People/tbi/jhshin/script/revi_gene/test/rgi_test_sample.fsa    protein Escherichia coli    none
```
### <br/>

### RUN command
```
snakemake -j all \
        --jobs 30 \
        --use-singularity \
        --singularity-args '--bind /data01,/data02,/data03,/data04,/data05,/data06,/data07,/TBI,/tmp -p' \
        --latency-wait 60 \
        -s /TBI/People/tbi/jhshin/script/impertoire/1.0.0/workflow/Snakefile \
        --cluster-config /TBI/People/tbi/jhshin/script/impertoire/1.0.0/config/cluster.json \
        --cluster "qsub -V -pe smp {cluster.threads} -N {cluster.jobName} -S /bin/bash -q 'rine.q@beluga|hippo|horse|jaguar|nanuq'"
```
### <br/><br/><br/>

## tools
- trust4
### <br/><br/><br/>

## TODO
-
## <br/><br/><br/>

## developer
- 신종환



