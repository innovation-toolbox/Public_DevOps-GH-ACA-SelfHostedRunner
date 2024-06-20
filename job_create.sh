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
        --scale-rule-metadata "github-runner=https://api.github.com" "owner=$REPO_OWNER" "runnerScope=org" "targetWorkflowQueueLength=1" "labels=org,python,python3.9" \
        --scale-rule-auth "personalAccessToken=personal-access-token" \
        --cpu "2.0" \
        --memory "4Gi" \
        --secrets "personal-access-token=$GITHUB_PAT" \
        --env-vars "GITHUB_PAT=secretref:personal-access-token" "ORG_URL=https://github.com/$REPO_OWNER" "REGISTRATION_TOKEN_API_URL=https://api.github.com/orgs/$REPO_OWNER/actions/runners/registration-token" "LABELS=org,python,python3.9" "GH_APP_CLIENT_ID=$GH_APP_CLIENT_ID" "PRIVATE_KEY=$PRIVATE_KEY"\
        --registry-server "$CONTAINER_REGISTRY_NAME.azurecr.io" \
        --registry-identity $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID \
        --mi-user-assigned $CONTAINER_APP_ENVIRONMENT_IDENTITY_ID