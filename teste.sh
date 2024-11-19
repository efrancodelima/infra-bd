#!/bin/bash

check_rds_cluster_exists() {
  local cluster_identifier=$1
  aws rds describe-db-clusters --query "DBClusters[?DBClusterIdentifier=='${cluster_identifier}'] | [0].DBClusterIdentifier" --output text
}

# Importa o cluster Aurora
CLUSTER_IDENTIFIER="lanchonete-aurora-cluster"
CLUSTER_EXISTS=$(check_rds_cluster_exists "$CLUSTER_IDENTIFIER")

echo "\nA: $CLUSTER_EXISTS\n"

if [ "$CLUSTER_EXISTS" == "" ]; then
  echo "Erro"
else
  echo "Sucesso"
fi

