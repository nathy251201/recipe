
Base:
https://github.com/terraform-google-modules/terraform-docs-samples.git
Folder: gke/quickstart/autopilot
## Ativar APIS no Google Cloud
- Compute Engine API
- Kubernetes Engine API
- Cloud SQL Admin API


```
export TF_VAR_bucket_name="my-terraform-state"
export TF_VAR_bucket_prefix="prod/state"
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/credentials.json"
```
Iniciar terraform com backend na gcloud
```
 terraform init   -backend-config="bucket=$TF_VAR_bucket_name"   -backend-config="prefix=$TF_VAR_bucket_prefix"   -backend-config="credentials=$GOOGLE_APPLICATION_CREDENTIALS"
```


Migrate state local para bucket na gcloud
```
 terraform init   -backend-config="bucket=$TF_VAR_bucket_name"   -backend-config="prefix=$TF_VAR_bucket_prefix"   -backend-config="credentials=$GOOGLE_APPLICATION_CREDENTIALS"  -migrate-state
```
