# TEMPORARY FILE

# This script is used to deploy the ACA job to the ACA Environment

export GITHUB_PAT=$1

CONTAINER_REGISTRY_NAME="TO_BE_REPLACED"
ACA_RESOURCE_GROUP="TO_BE_REPLACED"
ACA_ENVIRONMENT="TO_BE_REPLACED"
CONTAINER_APP_ENVIRONMENT_IDENTITY_ID="TO_BE_REPLACED" # Format is with /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}
REPO_OWNER="TO_BE_REPLACED"
REPO_NAME="TO_BE_REPLACED"

echo "##############################################"
echo "Add python agent"
echo "##############################################"

CONTAINER_IMAGE_NAME="ado-python-runner:1.0"
JOB_NAME="aca-job-ado-python-runner"

az containerapp job create -n "$JOB_NAME" -g "$ACA_RESOURCE_GROUP" --environment "$ACA_ENVIRONMENT" \
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
        --scale-rule-metadata "github-runner=https://api.github.com" "owner=$REPO_OWNER" "runnerScope=repo" "repos=$REPO_NAME" "targetWorkflowQueueLength=1" "labels=python,python3.9" \
        --scale-rule-auth "personalAccessToken=personal-access-token" \
        --cpu "2.0" \
        --memory "4Gi" \
        --secrets "personal-access-token=$GITHUB_PAT" \
        --env-vars "GITHUB_PAT=secretref:personal-access-token" "REPO_URL=https://github.com/$REPO_OWNER/$REPO_NAME" "REGISTRATION_TOKEN_API_URL=https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runners/registration-token" "LABELS=python,python3.9" \
        --registry-server "$CONTAINER_REGISTRY_NAME.azurecr.io" \
        --registry-identity $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID \
        --mi-user-assigned $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID


echo "##############################################"
echo "Add dotnet agent"
echo "##############################################"

CONTAINER_IMAGE_NAME="ado-dotnet-runner:latest"
JOB_NAME="aca-job-ado-dotnet-runner"

az containerapp job create -n "$JOB_NAME" -g "$ACA_RESOURCE_GROUP" --environment "$ACA_ENVIRONMENT" \
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
        --scale-rule-metadata "github-runner=https://api.github.com" "owner=$REPO_OWNER" "runnerScope=repo" "repos=$REPO_NAME" "targetWorkflowQueueLength=1" "labels=dotnet,dotnet-7" \
        --scale-rule-auth "personalAccessToken=personal-access-token" \
        --cpu "2.0" \
        --memory "4Gi" \
        --secrets "personal-access-token=$GITHUB_PAT" \
        --env-vars "GITHUB_PAT=secretref:personal-access-token" "REPO_URL=https://github.com/$REPO_OWNER/$REPO_NAME" "REGISTRATION_TOKEN_API_URL=https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runners/registration-token" "LABELS=dotnet,dotnet-7" \
        --registry-server "$CONTAINER_REGISTRY_NAME.azurecr.io" \
        --registry-identity $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID \
        --mi-user-assigned $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID


echo "##############################################"
echo "Add terraform agent"
echo "##############################################"

CONTAINER_IMAGE_NAME="ado-terraform-runner:latest"
JOB_NAME="aca-job-ado-terraform-runner"

az containerapp job create -n "$JOB_NAME" -g "$ACA_RESOURCE_GROUP" --environment "$ACA_ENVIRONMENT" \
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
        --scale-rule-metadata "github-runner=https://api.github.com" "owner=$REPO_OWNER" "runnerScope=repo" "repos=$REPO_NAME" "targetWorkflowQueueLength=1" "labels=terraform" \
        --scale-rule-auth "personalAccessToken=personal-access-token" \
        --cpu "2.0" \
        --memory "4Gi" \
        --secrets "personal-access-token=$GITHUB_PAT" \
        --env-vars "GITHUB_PAT=secretref:personal-access-token" "REPO_URL=https://github.com/$REPO_OWNER/$REPO_NAME" "REGISTRATION_TOKEN_API_URL=https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runners/registration-token" "LABELS=terraform" \
        --registry-server "$CONTAINER_REGISTRY_NAME.azurecr.io" \
        --registry-identity $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID \
        --mi-user-assigned $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID
