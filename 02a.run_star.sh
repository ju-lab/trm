#!/bin/bash
while read GSM long_name name;do
	[ -f fastq/fastq.$GSM.fastq.gz ] || continue
	#echo gsm: $GSM name: $name files: `ls fastq/fastq.$GSM.fastq.gz`
	run_star.sh $name fastq/fastq.$GSM.fastq.gz
done < sample_info/sample_id.tsv
