# spring-boot-jib

## redoc cloud run deployment

```bash
gcloud run deploy redoc-greetings-api --project $PROJECT_ID --image gcr.io/$PROJECT_ID/redoc --platform managed --region us-central1 --port 80 --cpu 1 --memory 256Mi --concurrency 80 --timeout 300 --update-env-vars SPEC_URL=https://<CLOUD_RUN_SPRING_BOOT_BASE_URI>/swagger.yaml
```
