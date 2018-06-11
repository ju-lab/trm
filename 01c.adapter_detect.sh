#!/bin/bash
#       ----------------
#PBS -N adaptor_detect
#       ----------------
# This script run fastqc & multiqc for multiple files
# This script is generaged by the command below
# /home/users/kjyi/bin/adapter-help-se.sh <...>
#
#PBS -q day
#PBS -o /dev/null
#PBS -e /dev/null
#PBS -l nodes=1:ppn=2,mem=8gb
cd /home/users/kjyi/Projects/trm

# output file
TRIM=./trim.qsh
# parameter
ERR_RATE=0.2 # cutadapt allow mismatch
# input
FILES="fastq/fastq.GSM2411307.fastq.gz fastq/fastq.GSM2411308.fastq.gz fastq/fastq.GSM2411309.fastq.gz fastq/fastq.GSM2411310.fastq.gz fastq/fastq.GSM2411311.fastq.gz fastq/fastq.GSM2411312.fastq.gz fastq/fastq.GSM2411313.fastq.gz fastq/fastq.GSM2411314.fastq.gz fastq/fastq.GSM2411315.fastq.gz fastq/fastq.GSM2411316.fastq.gz fastq/fastq.GSM2411317.fastq.gz fastq/fastq.GSM2411318.fastq.gz fastq/fastq.GSM2411319.fastq.gz fastq/fastq.GSM2411320.fastq.gz fastq/fastq.GSM2411321.fastq.gz fastq/fastq.GSM2411322.fastq.gz fastq/fastq.GSM2411323.fastq.gz fastq/fastq.GSM2411324.fastq.gz fastq/fastq.GSM2411325.fastq.gz fastq/fastq.GSM2411326.fastq.gz fastq/fastq.GSM2411327.fastq.gz fastq/fastq.GSM2411328.fastq.gz fastq/fastq.GSM2411329.fastq.gz fastq/fastq.GSM2411330.fastq.gz fastq/fastq.GSM2411331.fastq.gz fastq/fastq.GSM2411332.fastq.gz fastq/fastq.GSM2411333.fastq.gz fastq/fastq.GSM2411334.fastq.gz fastq/fastq.GSM2411335.fastq.gz fastq/fastq.GSM2411336.fastq.gz fastq/fastq.GSM2411337.fastq.gz fastq/fastq.GSM2411338.fastq.gz fastq/fastq.GSM2411339.fastq.gz fastq/fastq.GSM2411340.fastq.gz fastq/fastq.GSM2411341.fastq.gz fastq/fastq.GSM2411342.fastq.gz fastq/fastq.GSM2411343.fastq.gz fastq/fastq.GSM2411344.fastq.gz fastq/fastq.GSM2411345.fastq.gz fastq/fastq.GSM2411346.fastq.gz fastq/fastq.GSM2411347.fastq.gz fastq/fastq.GSM2411348.fastq.gz fastq/fastq.GSM2411349.fastq.gz fastq/fastq.GSM2411350.fastq.gz fastq/fastq.GSM2411351.fastq.gz fastq/fastq.GSM2411352.fastq.gz fastq/fastq.GSM2411353.fastq.gz fastq/fastq.GSM2411354.fastq.gz fastq/fastq.GSM2411355.fastq.gz fastq/fastq.GSM2411356.fastq.gz fastq/fastq.GSM2411357.fastq.gz fastq/fastq.GSM2411358.fastq.gz fastq/fastq.GSM2411359.fastq.gz fastq/fastq.GSM2411360.fastq.gz fastq/fastq.GSM2411361.fastq.gz fastq/fastq.GSM2411362.fastq.gz fastq/fastq.GSM2411363.fastq.gz fastq/fastq.GSM2411364.fastq.gz fastq/fastq.GSM2411365.fastq.gz fastq/fastq.GSM2411366.fastq.gz fastq/fastq.GSM2411367.fastq.gz fastq/fastq.GSM2411368.fastq.gz fastq/fastq.GSM2411369.fastq.gz fastq/fastq.GSM2411370.fastq.gz fastq/fastq.GSM2411371.fastq.gz fastq/fastq.GSM2411372.fastq.gz fastq/fastq.GSM2411373.fastq.gz fastq/fastq.GSM2411374.fastq.gz"

rm -rf $TRIM
cat <<EOF > $TRIM
#!/bin/bash
#PBS -N cut_adapt
#PBS -q day
#PBS -o /dev/null
#PBS -e /dev/null
#PBS -l nodes=1:ppn=2,mem=8gb
cd \$PBS_O_WORKDIR
ERR_RATE=$ERR_RATE
LOG=./log/cut_adapt.log
mkdir -p ./log
rm -rf \$LOG
##############################
EOF
F=( $FILES )
for i in ${!F[@]};do
	echo $i
	F1=${F[i]}
	python3 ~/src/detect_adapter.py $F1 2>> $TRIM |
	sed '$ s/^/AD1=/; $ s/\t/;F1=/' >> $TRIM
	cat <<EOF >> $TRIM
O1=\$(echo \$F1 | sed 's/[^/]*$/trim_&/');
cutadapt -m 5 -e \$ERR_RATE -a \$AD1 -o \$O1 \$F1 >>\${F1/.fastq.gz}'.cutadapt.log'
EOF
done
exit 0 
