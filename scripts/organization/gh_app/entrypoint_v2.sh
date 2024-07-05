#!/usr/bin/env bash

#Importing functions from .functions.sh file, split for clarity
. entrypoint.functions.sh

set -o pipefail

# Retrieving environment variables in a clean format (with or without quotes) for ease of use
gh_app_private_key=$GH_APP_PRIVATE_KEY
registration_token_api_url=$REGISTRATION_TOKEN_API_URL
gh_url=$GH_URL
labels=$LABELS
gh_app_client_id=$GH_APP_CLIENT_ID
gh_app_installation_id=$GH_APP_INSTALLATION_ID

pvk=$(cat ./pvkey.pem)

echo "pvk is " "$pvk"

# private_key=$(echo -e $gh_app_private_key)
private_key=$(printf '%q' "$gh_app_private_key")

echo "GH pv key is :" "${GH_APP_PRIVATE_KEY}"
echo "Private Key is : " 
echo -e "$gh_app_private_key"

printf 'client id is %s' $client_id
echo 'private key is ' $private_key

now=$(date +%s)
iat=$((${now} - 60)) # Issues 60 seconds in the past
exp=$((${now} + 600)) # Expires 10 minutes in the future

b64enc() { openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n'; }

header_json='{
    "typ":"JWT",
    "alg":"RS256"
}'
# Header encode
header=$(echo -n "${header_json}" | b64enc)

payload_json='{
    "iat":'"${iat}"',
    "exp":'"${exp}"',
    "iss":'"${gh_app_client_id}"'
}'
# Payload encode
payload=$(echo -n "${payload_json}" | b64enc)

# Signature
header_payload="${header}"."${payload}"
signature=$(
    openssl dgst -sha256 -sign <(eval echo -n -e "${private_key}") \
    <(echo -n "${header_payload}") | b64enc
)

# Create JWT
jwt="${header_payload}"."${signature}"

if [ -n "$jwt" ]; then
    echo "JWT generated successfully"
else
    echo "Failed to generate JWT"
    exit 1
fi

# Get the access token
access_token=$(get_access_token "${gh_app_installation_id}" "${jwt}")

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
#./config.sh --url ${gh_url} --token $reg_token --unattended --ephemeral --labels ${labels} && ./run.sh