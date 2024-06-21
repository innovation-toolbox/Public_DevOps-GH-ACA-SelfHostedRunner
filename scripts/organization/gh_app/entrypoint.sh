#!/usr/bin/env bash

#Importing functions from .functions.sh file, split for clarity
. entrypoint.functions.sh

set -o pipefail

# set local variables from ENV variables for clarity and ease of potential future evolutions
pem=${PRIVATE_KEY}
client_id=${GH_APP_CLIENT_ID}
inst_id=${GH_APP_INSTALLATION_ID}
org=${GH_URL}
reg_url=${REGISTRATION_TOKEN_API_URL}
labels=${LABELS}

# Create JWT from GH app client id and private key
jwt=$(generate_jwt "${client_id}" "${pem}")

if [ -n "$jwt" ]; then
    echo "JWT generated successfully"
else
    echo "Failed to generate JWT"
    exit 1
fi

# Get the access token
access_token=$(get_access_token "${inst_id}" "${jwt}")

if [ -n "$access_token" ]; then
    echo "access token generated successfully"
else
    echo "Failed to generate access token"
    exit 1
fi

# Retrieve a short lived runner registration token using the GH App Access Token
reg_token=$(get_registration_token "${reg_url}" "${access_token}")

if [ -n "$reg_token" ]; then
    echo "Registration token generated successfully"
else
    echo "Failed to generate registration token"
    exit 1
fi

# Configure and run the Github Self Hosted Runner
echo "Starting the Github Self Hosted Runner ..."
./config.sh --url $org --token $reg_token --unattended --ephemeral --labels $labels && ./run.sh