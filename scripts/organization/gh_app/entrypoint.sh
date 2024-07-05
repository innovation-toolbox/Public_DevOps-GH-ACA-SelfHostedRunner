#!/usr/bin/env bash

#Importing functions from .functions.sh file, split for clarity
. entrypoint.functions.sh

set -o pipefail

# Documentation des variables d'environnement nécessaires
# GH_APP_PRIVATE_KEY: Clé privée de l'application GitHub. Exemple: "-----BEGIN PRIVATE KEY-----\n..."
# REGISTRATION_TOKEN_API_URL: URL de l'API pour obtenir le jeton d'inscription. Exemple: "https://api.github.com/..."
# GH_URL: URL de GitHub ou de l'instance GitHub Enterprise. Exemple: "https://github.com"
# LABELS: Étiquettes à appliquer au runner. Exemple: "linux,x64,production"
# GH_APP_CLIENT_ID: ID client de l'application GitHub. Exemple: "Iv1.1234567890abcdef"
# GH_APP_INSTALLATION_ID: ID d'installation de l'application GitHub. Exemple: "1234567"

# Liste des variables d'environnement requises
required_vars=("GH_APP_PRIVATE_KEY" "REGISTRATION_TOKEN_API_URL" "GH_URL" "LABELS" "GH_APP_CLIENT_ID" "GH_APP_INSTALLATION_ID")

# Vérification que toutes les variables requises sont définies
for var in "${required_vars[@]}"; do
  if [ -z "${!var}" ]; then
    echo "Erreur: La variable d'environnement '$var' n'est pas définie." >&2
    exit 1
  fi
done

# Retrieving environment variables in a clean format for ease of use
gh_app_private_key=$GH_APP_PRIVATE_KEY
registration_token_api_url=$REGISTRATION_TOKEN_API_URL
gh_url=$GH_URL
labels=$LABELS
gh_app_client_id=$GH_APP_CLIENT_ID
gh_app_installation_id=$GH_APP_INSTALLATION_ID

# Create JWT from GH app client id and private key
jwt=$(generate_jwt "$GH_APP_CLIENT_ID" "$GH_APP_PRIVATE_KEY")

if [ -n "$jwt" ]; then
    echo "JWT generated successfully"
else
    echo "Failed to generate JWT"
    exit 1
fi

# Get the access token
access_token=$(get_access_token "${GH_APP_INSTALLATION_ID}" "${jwt}")

if [ -n "$access_token" ]; then
    echo "access token generated successfully : ${access_token}"
else
    echo "Failed to generate access token"
    exit 1
fi

# Retrieve a short lived runner registration token using the GH App Access Token
reg_token=$(get_registration_token "${registration_token_api_url}" "${access_token}")

if [ -n "$reg_token" ]; then
    echo "Registration token generated successfully : ${reg_token}"
else
    echo "Failed to generate registration token"
    exit 1
fi

# Configure and run the Github Self Hosted Runner
echo "Starting the Github Self Hosted Runner ..."
./config.sh --url ${gh_url} --token $reg_token --unattended --ephemeral --labels ${labels} && ./run.sh