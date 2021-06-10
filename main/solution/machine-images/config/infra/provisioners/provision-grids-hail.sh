#!/usr/bin/env bash

###
# Context of GRIDS EMR
###

# emr 6.2.0
# Hadoop 3.2.1
# JupyterHub 1.1.0
# Livy 0.7.0
# Scala 2.12.10
# Spark 3.0.1
# Zeppelin 0.9.0

# Amazon Linux 2 AMI
# python 2.7.18
# python3 3.7.9

# Variables
# Hail 0.2.65 bug on requirements #10352
HAIL_VERSION="0.2.60"
# HAIL_VERSION="0.2.67"

# Install java
sudo yum install -y java-1.8.0-openjdk-devel
sudo ln -s /etc/alternatives/java_sdk/include /etc/alternatives/jre/include
# Install build libs 
sudo yum install -y gcc-c++ cmake lz4 lz4-devel
# Install git
sudo yum install -y git

# Clone Hail
sudo mkdir -p /opt/broad-hail
cd /opt/broad-hail
sudo git clone --branch $HAIL_VERSION --depth 1 https://github.com/broadinstitute/hail.git .
cd /opt/broad-hail/hail/

# Build Hail as of emr specs
# Run spark-shell to check Spark and Scala version

# emr-6.2.0
sudo make install-on-cluster HAIL_COMPILE_NATIVES=1 SCALA_VERSION=2.12.10 SPARK_VERSION=3.0.1

# emr-6.3.0
# sudo make install-on-cluster HAIL_COMPILE_NATIVES=1 SCALA_VERSION=2.12.10 SPARK_VERSION=3.1.1

# # Create Zeppelin folder
sudo mkdir -p /opt/zeppelin
sudo chmod -R 777 /opt/zeppelin/
cd /opt/zeppelin
sudo git clone --depth 1 https://github.com/c-BIG/demo-notebooks.git .

# # Update packages as of GRIDS extention
sudo python3 -m pip install wheel
sudo python3 -m pip install bkzep
# umap-learn==0.5.1

###
# END
###
# dev-sg-npmsw-mh-GRIDS-EMR-AMI-1623317806
# ami-03ee8b83392e6825b