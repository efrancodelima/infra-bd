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
AURORA_CLUSTER_NAME="lanchonete-aurora-cluster"
AURORA_CLUSTER_INSTANCE_NAME="lanchonete-aurora-cluster-instance"
ROLE_NAME="lanchonete-aurora-role"
POLICY_NAME="AmazonRDSFullAccess"
SECURITY_GROUP_ID="sg-0b9ded624a8d10261"
SUBNET_GROUP_NAME="lanchonete-aurora-subnet-group"

# Importa o cluster aurora
import_resource "aws_rds_cluster" "tf_aurora_cluster" "${AURORA_CLUSTER_NAME}"

# Importa o cluster instance
import_resource "aws_rds_cluster_instance" "tf_aurora_instance" "${AURORA_CLUSTER_INSTANCE_NAME}"

# Importa a role usada no cluster aurora
import_resource "aws_iam_role" "tf_aurora_role" "${ROLE_NAME}"

# Importa a policy
import_resource "aws_iam_role_policy_attachment" "tf_rds_policy" \
"${ROLE_NAME}/arn:aws:iam::aws:policy/${POLICY_NAME}"

# Importa o security group
import_resource "aws_security_group" "tf_aurora_security_group" "${SECURITY_GROUP_ID}"

# Importa o subnet group
import_resource "aws_db_subnet_group" "tf_subnet_group" "${SUBNET_GROUP_NAME}"
