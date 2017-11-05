bwa mem -t 8 data/MDR-CQ.fa data/C_H3JFKDMXX_L1_1.clean.fq.gz data/C_H3JFKDMXX_L1_2.clean.fq.gz \
| samtools view -b - | samtools sort -o C_H3JFKDMXX_L1.bam
samtools index C_H3JFKDMXX_L1.bam
