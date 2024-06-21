export ACA_JOB_NAME="aca-job-ghapp-runner-python"
export ACA_RESOURCE_GROUP="rg-gh-oidc-demo"
export ACA_ENVIRONMENT="aca-env-gh-bycn-oidc-demo"
export CONTAINER_REGISTRY_NAME="acrjskubeeducwe"
export CONTAINER_IMAGE_NAME="gh-runner-python:ghapp-1.0"
export GH_OWNER="innovation-toolbox"
export ORG_NAME="innovation-toolbox"
export GH_APP_CLIENT_ID="926833"
export GH_APP_INSTALLATION_ID="52060931"
export GH_APP_PRIVATE_KEY="$(cat "../organization/gh_app/pvkey.pem")"
export CONTAINER_APP_ENVIRONMENT_IDENTITY_ID="/subscriptions/fbcfc68c-3c2e-4ff7-bea4-da2642809f50/resourceGroups/rg-gh-oidc-demo/providers/Microsoft.ManagedIdentity/userAssignedIdentities/userid-gh-bycn-oidc-demo"

az containerapp job create -n "$ACA_JOB_NAME" -g "$ACA_RESOURCE_GROUP" --environment "$ACA_ENVIRONMENT" \
        --trigger-type Event \
        --replica-timeout 3600 \
        --replica-retry-limit 1 \
        --replica-completion-count 1 \
        --parallelism 1 \
        --image "$CONTAINER_REGISTRY_NAME.azurecr.io/$CONTAINER_IMAGE_NAME" \
        --min-executions 0 \
        --max-executions 10 \
        --polling-interval 30 \
        --scale-rule-name "github-runner" \
        --scale-rule-type "github-runner" \
        --scale-rule-metadata "github-runner=https://api.github.com" "applicationID=$GH_APP_CLIENT_ID" "installationID=$GH_APP_INSTALLATION_ID" "owner=$GH_OWNER" "runnerScope=org" "targetWorkflowQueueLength=1" "labels=org,python,python3.9" \
        --scale-rule-auth "appKey=app-key" \
        --cpu "2.0" \
        --memory "4Gi" \
        --secrets "app-key=$GH_APP_PRIVATE_KEY" \
        --env-vars "PRIVATE_KEY=secretref:app-key" "GH_URL=https://github.com/$ORG_NAME" "REGISTRATION_TOKEN_API_URL=https://api.github.com/orgs/$ORG_NAME/actions/runners/registration-token" "LABELS=org,python,python3.9" "GH_APP_CLIENT_ID=$GH_APP_CLIENT_ID" "GH_APP_INSTALLATION_ID=$GH_APP_INSTALLATION_ID"\
        --registry-server "$CONTAINER_REGISTRY_NAME.azurecr.io" \
        --registry-identity $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID \
        --mi-user-assigned $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID