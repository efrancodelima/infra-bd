#!/bin/bash

import_resource() {
  local resource_type=$1
  local resource_name=$2
  local resource_id=$3

  terraform import \
  -var="db_username=$DB_USERNAME" \
  -var="db_password=$DB_PASSWORD" \
  "$resource_type.$resource_name" "$resource_id" || true
}

# Constantes
CLUSTER_NAME="lanchonete-aurora-cluster"
INSTANCE_READER_NAME=$(aws rds describe-db-clusters --query "DBClusters[?DBClusterIdentifier=='$CLUSTER_NAME'].DBClusterMembers[0].DBInstanceIdentifier" --output text)
INSTANCE_WRITER_NAME=$(aws rds describe-db-clusters --query "DBClusters[?DBClusterIdentifier=='$CLUSTER_NAME'].DBClusterMembers[1].DBInstanceIdentifier" --output text)
ROLE_NAME="lanchonete-aurora-role"
POLICY_NAME="AmazonRDSFullAccess"
SECURITY_GROUP_NAME="lanchonete-aurora-security-group"
SUBNET_GROUP_NAME="lanchonete-aurora-subnet-group"

# Importa o cluster aurora
import_resource "aws_rds_cluster" "tf_aurora_cluster" "${CLUSTER_NAME}"

# Importa as instâncias do cluster
import_resource "aws_rds_cluster_instance" "tf_instance_reader" "${INSTANCE_READER_NAME}"
import_resource "aws_rds_cluster_instance" "tf_instance_writer" "${INSTANCE_WRITER_NAME}"

# Importa a role usada no cluster aurora
import_resource "aws_iam_role" "tf_role" "${ROLE_NAME}"

# Importa a policy
import_resource "aws_iam_role_policy_attachment" "tf_rds_policy" \
"${ROLE_NAME}/arn:aws:iam::aws:policy/${POLICY_NAME}"

# Importa o security group
SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=${SECURITY_GROUP_NAME}" --query 'SecurityGroups[0].GroupId' --output text)
import_resource "aws_security_group" "tf_security_group" "${SECURITY_GROUP_ID}"

# Importa o subnet group
import_resource "aws_db_subnet_group" "tf_subnet_group" "${SUBNET_GROUP_NAME}"
