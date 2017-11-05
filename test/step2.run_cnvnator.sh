#!/bin/bash

source /its1/GB_BT2/jianzuoyi/biosoft/CNVnator/CNVnator_v0.3.3/src/root/bin/thisroot.sh

../CNVnator_v0.3.3/cnvnator_wrapper.py -w 100 -b C_H3JFKDMXX_L1.bam -o C_H3JFKDMXX_L1 -g data/MDR-CQ.fa -c CP019114 --cnvnator  ../CNVnator_v0.3.3/cnvnator --samtools ../CNVnator_v0.3.3/samtools/samtools
