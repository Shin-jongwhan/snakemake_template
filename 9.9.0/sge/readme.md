### 250829
# SGE 이용 방법
### snakemake 9.9.0을 설치하고 난 후 별도로 플러그인을 설치해야 한다.
```
conda install -c conda-forge -c bioconda snakemake-executor-plugin-cluster-generic
# or
pip install snakemake-executor-plugin-cluster-generic
```
### <br/>

### 그 다음 다음과 같이 명령어를 사용하면 된다.
### SGE 관련 중요 옵션
- --executor cluster-generic
- --cluster-generic-submit-cmd "qsub -V -pe smp {threads} -o /dev/null -e /dev/null -N {rule}.{wildcards} -S /bin/bash -q 'rine.q@beluga|hippo|horse|jaguar|nanuq'"
```
snakemake --jobs 30 \
                --profile /biarchive/project/jhshin/analysis/ica_wgs/TBD251048_24797_20250819/config/profile \
                --configfile /biarchive/project/jhshin/analysis/ica_wgs/TBD251048_24797_20250819/config/config.yaml \
                --executor cluster-generic \
                --cluster-generic-submit-cmd "qsub -V -pe smp {threads} -o /dev/null -e /dev/null -N {rule}.{wildcards} -S /bin/bash -q 'rine.q@beluga|hippo|horse|jaguar|nanuq'" \
                --use-singularity \
                --singularity-args '--bind /biarchive,/biarchive2,/biscratch,/TBI,/tmp -p' \
                --latency-wait 60 \
                -s /TBI/People/tbi/jhshin/pipeline/ica_wgs_somatic/workflow/Snakefile \
                -p \
                --forcerun all

```
