#!/bin/sh -l
set -o pipefail
 
client_id=$GH_APP_CLIENT_ID # Client ID as first argument
 
pem=$PRIVATE_KEY # file path of the private key as second argument
 
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
JWT="${header_payload}"."${signature}"
# printf '%s\n' "JWT: $JWT"
 
access_tokens="$(curl --request POST \
--url "https://api.github.com/app/installations/52039177/access_tokens" \
--header "Accept: application/vnd.github+json" \
--header "Authorization: Bearer $JWT" \
--header "X-GitHub-Api-Version: 2022-11-28")"
 
# Retrieve a short lived runner registration token using the PAT
REGISTRATION_TOKEN="$(curl -X POST -fsSL \
  -H 'Accept: application/vnd.github.v3+json' \
  -H "Authorization: Bearer 'ghs_$access_tokens'" \
  -H 'X-GitHub-Api-Version: 2022-11-28' \
  "$REGISTRATION_TOKEN_API_URL" \
  | jq -r '.token')"
 
./config.sh --url $ORG_URL --token $REGISTRATION_TOKEN --unattended --ephemeral --labels $LABELS && ./run.sh