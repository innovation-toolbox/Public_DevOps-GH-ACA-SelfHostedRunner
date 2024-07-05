IMAGE_TAG=ghapp-1.5
ACA_JOB_NAME=<ACA-Job-Name> #Name of the job to be created
ACA_RESOURCE_GROUP=<ACA-RG-Name>
ACA_ENVIRONMENT=<ACA-Environment-Name>
CONTAINER_REGISTRY_NAME=<ACR-Name>
CONTAINER_IMAGE_NAME=<Repository:tag>
GH_OWNER=<YOUR_GH_ORG>
ORG_NAME=<YOUR_GH_ORG>
GH_APP_CLIENT_ID=<CLIENT-ID>
GH_APP_INSTALLATION_ID=<INSTALLATION-ID>
GH_APP_PRIVATE_KEY=-----BEGIN RSA PRIVATE KEY-----\n<'value_with_\n_per_each_line'>\n-----END RSA PRIVATE KEY-----\n
LABELS=org,python,python3.9 #comma separated list of labels
CONTAINER_APP_ENVIRONMENT_IDENTITY_ID=/subscriptions/<SUB-ID>/resourceGroups/<RG-Name>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<MI-Name>
REGISTRATION_TOKEN_API_URL=https://api.github.com/orgs/<ORG_NAME>/actions/runners/registration-token
GH_URL=https://github.com/<ORG_NAME>