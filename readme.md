### 231201
## snakemake 로 파이프라인을 만들 때에 쓰는 template
### snakemake 파이프라인을 처음부터 만들려면 좀 헷갈린다. 그래서 미리 만들어진 것을 기준으로 개발할 수 있도록 템플릿을 개발하였다.
### <br/><br/><br/>

## impertoire/1.0.0
### 특징
- qsub cluster 사용 가능
- config 정의
- docker container 사용 가능
- singularity 사용 가능
- samples.tsv 에 샘플 기입
- workflow/rules/common.smk 에서 config 와 output, option 에 대한 정의
### <br/>

### RUN
#### * qsub cluster 를 사용하려면 --jobs, --cluster-config 옵션을 같이 써야 한다.
```
snakemake -j all \
        --jobs 30 \
        --use-singularity \
        --singularity-args '--bind /data01,/data02,/data03,/data04,/data05,/data06,/data07,/TBI,/tmp -p' \
        --latency-wait 60 \
        -s /TBI/People/tbi/jhshin/script/impertoire/1.0.0/workflow/Snakefile \
        --cluster-config /TBI/People/tbi/jhshin/script/impertoire/1.0.0/config/cluster.json \
        --cluster "/TBI/Opt/SGE/sge-8.1.8/bin/lx-amd64/qsub -V -pe smp {cluster.threads} -N {cluster.jobName} -S /bin/bash -q 'rine.q@beluga|hippo|horse|jaguar|nanuq'"
```
### <br/><br/><br/>

