#!/usr/bin/env bash

set -o pipefail

# set local variables from ENV variables for clarity and ease of potential future evolutions
pem=${PRIVATE_KEY}
client_id=${GH_APP_CLIENT_ID}
inst_id=${GH_APP_INSTALLATION_ID}
org=${ORG_URL}
reg_url=${REGISTRATION_TOKEN_API_URL}
labels=${LABELS}

# Generate JWT
now=$(date +%s)
iat=$((${now} - 60)) # Issues 60 seconds in the past
exp=$((${now} + 600)) # Expires 10 minutes in the future
 
b64enc() { openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n'; }
 
header_json='{
    "typ":"JWT",
    "alg":"RS256"
}'
# Header encode
header=$( echo -n "${header_json}" | b64enc )
 
payload_json='{
    "iat":'"${iat}"',
    "exp":'"${exp}"',
    "iss":'"${client_id}"'
}'
# Payload encode
payload=$( echo -n "${payload_json}" | b64enc )
 
# Signature
header_payload="${header}"."${payload}"
signature=$(
    openssl dgst -sha256 -sign <(echo -n "${pem}") \
    <(echo -n "${header_payload}") | b64enc
)

# Create JWT
jwt="${header_payload}"."${signature}"

access_token="$(curl --request POST \
--url "https://api.github.com/app/installations/${inst_id}/access_tokens" \
--header "Accept: application/vnd.github+json" \
--header "Authorization: Bearer $jwt" \
--header "X-GitHub-Api-Version: 2022-11-28")"

token=$(echo "${access_token}" | jq -r '.token')

# Retrieve a short lived runner registration token using the GH App Access Token
reg_token="$(curl --request POST \
    --url "${reg_url}" \
    --header 'Accept: application/vnd.github.v3+json' \
    --header "Authorization: Bearer $token" \
    --header 'X-GitHub-Api-Version: 2022-11-28' \
    -fsSL \
  | jq -r '.token')"


./config.sh --url $org --token $reg_token --unattended --ephemeral --labels $labels && ./run.sh