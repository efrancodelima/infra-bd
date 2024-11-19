#!/bin/bash

import_resource() {
  local resource_type=$1
  local resource_name=$2
  local resource_id=$3

  terraform import \
  -var="aws_region=$AWS_REGION" \
  -var="aws_zone_1=$AWS_ZONE_1" \
  -var="aws_zone_2=$AWS_ZONE_2" \
  -var="db_username=$DB_USERNAME" \
  -var="db_password=$DB_PASSWORD" \
  "$resource_type.$resource_name" "$resource_id" || true
}

get_first_vpc_id() {
  local vpc_name=$1
  aws ec2 describe-vpcs --filters \
  "Name=tag:Name,Values=${vpc_name}" --query "Vpcs[0].VpcId" --output text
}

get_first_subnet_id() {
  local subnet_name=$1
  aws ec2 describe-subnets --filters \
  "Name=tag:Name,Values=${subnet_name}" --query "Subnets[0].SubnetId" --output text
}

get_aurora_instance_id() {
  local instance_name=$1
  local instance_index=$2
  aws rds describe-db-instances --query \
  "DBInstances[?DBClusterIdentifier=='${instance_name}'].DBInstanceIdentifier | [${instance_index}]" --output text
}

get_first_security_group_id() {
  local security_group_name=$1
  aws ec2 describe-security-groups \
  --filters "Name=group-name,Values=${security_group_name}" --query "SecurityGroups[0].GroupId" --output text
}

get_first_subnet_group_id() {
  local subnet_group_name=$1
  aws rds describe-db-subnet-groups \
  --query "DBSubnetGroups[?DBSubnetGroupName=='${subnet_group_name}'].DBSubnetGroupArn" --output text
}

# Importa o cluster Aurora
import_resource "aws_rds_cluster" "tf_aurora_cluster" "lanchonete-aurora-cluster"

# Importa a instância do cluster
AURORA_INSTANCE_ID=$(get_aurora_instance_id "lanchonete-aurora-cluster" "0")
import_resource "aws_rds_cluster_instance" "tf_aurora_instance" "$AURORA_INSTANCE_ID"

# Importa o Security Group
SECURITY_GROUP_ID=$(get_first_security_group_id "aurora-security-group")
import_resource "aws_security_group" "tf_aurora_security_group" $SECURITY_GROUP_ID

# Importa o Subnet Group
SUBNET_GROUP_ID=$(get_first_subnet_group_id "aurora-subnet-group")
import_resource "aws_db_subnet_group" "tf_subnet_group" "$SUBNET_GROUP_ID"

# Importa a VPC
VPC_ID=$(get_first_vpc_id "lanchonete-vpc")
import_resource "aws_vpc" "tf_vpc" "$VPC_ID"

# Importa as subnets
PUBLIC_SUBNET_0_ID=$(get_first_subnet_id "lanchonete-public-subnet-0")
PUBLIC_SUBNET_1_ID=$(get_first_subnet_id "lanchonete-public-subnet-1")
PRIVATE_SUBNET_0_ID=$(get_first_subnet_id "lanchonete-private-subnet-0")
PRIVATE_SUBNET_1_ID=$(get_first_subnet_id "lanchonete-private-subnet-1")

import_resource "aws_subnet" "tf_public_subnet[0]" "$PUBLIC_SUBNET_0_ID"
import_resource "aws_subnet" "tf_public_subnet[1]" "$PUBLIC_SUBNET_1_ID"
import_resource "aws_subnet" "tf_private_subnet[0]" "$PRIVATE_SUBNET_0_ID"
import_resource "aws_subnet" "tf_private_subnet[1]" "$PRIVATE_SUBNET_1_ID"
