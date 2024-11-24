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

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# RDS AURORA
# Constantes
AURORA_CLUSTER_NAME="lanchonete-aurora-cluster"
AURORA_INSTANCE_NAME="lanchonete-aurora-cluster-0"
ROLE_NAME="lanchonete-aurora-role"
POLICY_NAME="AmazonRDSFullAccess"
SECURITY_GROUP_ID="sg-029d2fafc37f26157"
SUBNET_GROUP_NAME="lanchonete-aurora-subnet-group"

# Importa o cluster aurora
import_resource "aws_rds_cluster" "tf_aurora_cluster" "${AURORA_CLUSTER_NAME}"

# Importa a instância do cluster
import_resource "aws_rds_cluster_instance" "tf_aurora_instance" "${AURORA_INSTANCE_NAME}"

# Importa a role usada no cluster aurora
import_resource "aws_iam_role" "tf_aurora_role" "${ROLE_NAME}"

# Importa a policy
import_resource "aws_iam_role_policy_attachment" "tf_rds_policy" \
"${ROLE_NAME}/arn:aws:iam::aws:policy/${POLICY_NAME}"

# Importa o security group
import_resource "aws_security_group" "tf_aurora_security_group" "${SECURITY_GROUP_ID}"

# Importa o subnet group
import_resource "aws_db_subnet_group" "tf_subnet_group" "${SUBNET_GROUP_NAME}"


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# REDE
# Constantes
VPC_ID="vpc-0ea4cbbd6e92e3abe"
PUBLIC_SUBNET_ID_0="subnet-04210519054c41980"
PUBLIC_SUBNET_ID_1="subnet-0dcb9a941b96ae94b"
PRIVATE_SUBNET_ID_0="subnet-0a35b1afb7b19cda1"
PRIVATE_SUBNET_ID_1="subnet-0b03f410da640c4cb"
ROUTE_TABLE_ID="rtb-0d2b24549dac7dc8e"
DHCP_OPTIONS_ID="dopt-0c8fc57b079c91172"
INTERNET_GATEWAY_ID="igw-0a0f387d0f166b3a6"

# Importa a VPC
import_resource "aws_vpc" "tf_vpc" "${VPC_ID}"

# Importa as subnets
import_resource "aws_subnet" "tf_public_subnet[0]" "${PUBLIC_SUBNET_ID_0}"
import_resource "aws_subnet" "tf_public_subnet[1]" "${PUBLIC_SUBNET_ID_1}"
import_resource "aws_subnet" "tf_private_subnet[0]" "${PRIVATE_SUBNET_ID_0}"
import_resource "aws_subnet" "tf_private_subnet[1]" "${PRIVATE_SUBNET_ID_1}"

# Importa a route table
import_resource "aws_route_table" "tf_route_table" "${ROUTE_TABLE_ID}"

# Importa as associações entre a route table e as subnets
import_resource "aws_route_table_association" "tf_rt_assoc_1" "${PUBLIC_SUBNET_ID_0}/${ROUTE_TABLE_ID}"
import_resource "aws_route_table_association" "tf_rt_assoc_2" "${PUBLIC_SUBNET_ID_1}/${ROUTE_TABLE_ID}"

# Importa o DHCP options
import_resource "aws_vpc_dhcp_options" "tf_dhcp_options" "${DHCP_OPTIONS_ID}"

# Importa o DHCP options associations
import_resource "aws_vpc_dhcp_options_association" "tf_dhcp_options_association" "${VPC_ID}"

# Importa o internet gateway
import_resource "aws_internet_gateway" "tf_internet_gateway" "${INTERNET_GATEWAY_ID}"
