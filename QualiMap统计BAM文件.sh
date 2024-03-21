#!bin/bash
#模块
#bamqc模块（BAM QC）：用于单个NGS样本bam文件的QC统计。
#rnaseq模块（RNA-seq QC）：用于转录组RNA-seq样本bam文件的QC统计。
#multi-bamqc模块（Multi-sample BAM QC）：用于多样本NGS的bam文件的分组QC统计，即包含个体数据，又包含分组比较。
#counts模块（Counts QC）：可用于转录组数据计数的统计，用于量化表达水平。
#clustering模块：用于表观基因组（例如甲基化）特征的聚类。
#comp-counts模块：输入bam文件和注释文件，计算映射到每个区域的reads数量

###安装
#wget https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.3.zip
#unzip qualimap_v2.3.zip
#cd qualimap_v2.3
#./qualimap -h

#bamqc模块（BAM QC）#
qualimap bamqc -bam sample.bam -outformat PDF:HTML -outdir out -nt 12 --java-mem-size=10G

#####参数

   # -bam sample.bam：指定bam文件。
   # -outformat PDF:HTML：输出文件格式PDF和HTML，默认是HTML。
   #-outdir out：输出文件的目录，不指定则生成sample_stats目录。
   # -nt 12：线程12，默认是144。
   # --java-mem-size=10G：设置最大内存为10G，建议每个模块都设置。

# result
#    globals：reads的mapping情况
#    ACGT content：四种碱基和N的含量
#    Coverage：深度
#   Mapping Quality：平均值
#    Insert Size：平均值和标准差
#    Mismatches and indels：统计值
#    Chromosome stats：每条染色体的长度，mapped bases，mean coverage，standard deviation。
#    Coverage across reference：贯穿整个基因组的深度（coverage）和GC含量
#    Coverage Histogram：深度分布
#    genome fraction coverage
#    duplication rate histogram
#    mapped reads nucleotide content
#    mapped reads GC-content distribution
#    mapped reads clipping profile
#    homopolymer indels
#    mapping quality across reference
#    mapping quality histogram
#    insert size across reference
#    insert size histogram
#    QualiMap的所有coverage都是深度，而不是覆盖度。

#rnaseq模块#
#与bamqc模块相似，用于RNA-seq数据的bam文件的统计。
qualimap rnaseq -bam rnaseq_sample.bam -outdir rnaseq_out -outformat PDF:HTML --java-mem-size=10G

#    参数
#    -bam rnaseq_sample.bam：输入的bam文件。
#    -outdir rnaseq_out：输出文件的目录。
#    -outformat PDF:HTML：输出文件格式PDF和HTML，默认是HTML。
#    --java-mem-size=10G：设置最大内存为10G


#multi-bamqc模块#

#多样本NGS的bam文件的统计和比较。
qualimap multi-bamqc -r -d qualimap.list -outdir out -outformat PDF:HTML --java-mem-size=10G

#参数

#    -r：multi-bamqc模块可以输入bam文件或者bamqc模块的结果，如果输入bam文件则需加-r参数。
#    -d qualimap.list：输入文件列表，qualimap有三列，每行一个样本，第一列样品名称，第二列包含路径的bam文件/bamqc结果目录，第三列组名。
#    如果用-r，qualimap.list的第二列则应为bam文件，此时multi-bamqc模块会先对每个样本运行bamqc，bamqc的结果存放在bam文件所在目录下，再进行multi-bamqc的统计。默认是用4个线程，一个样本一个样本单独跑bamqc。
#    -outdir out：结果文件输出目录。
#    -outformat PDF:HTML：结果文件格式，pdf和html都要。
#    --java-mem-size=10G：设置最大内存为10G。

#Others module#




