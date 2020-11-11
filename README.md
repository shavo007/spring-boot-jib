# spring-boot-jib

## Buildpacks

Install docker and download [the pack tool](https://buildpacks.io/docs/tools/pack/)

>Buildpacks inspect your source and try to identify it as something it knows how to build. 

```bash
pack build --builder=gcr.io/buildpacks/builder:v1 spring-boot-web:buildpacks

docker run --rm -it -ePORT=8080 -p8080:8080 spring-boot-web:buildpacks
```

### Pros
- Buildpacks are nice because in many cases they just work and you don't have to do anything special to turn your source into something runnable.
- Auto detection -  Detection criteria is specific to each buildpack – for instance, an NPM buildpack might look for a `package.json`, and a Go buildpack might look for Go `source` files.

### Cons
- image is quite bulky
- all of the dependencies and compiled application code are stored in a single layer

## Jib

Build with local docker daemon

```bash

./gradlew jibDockerBuild
docker run --rm -it -ePORT=8080 -p8080:8080 spring-boot-web:jib
```

### Pros
- Unlike buildpack, original src code is not included
- dont even need docker if you store the image in a container registry such as docker hub or google cloud container registry
- base image is distroless so no package managers or shells
- Gradle Jib `extensions` for Spring Boot, which provide a convenient way to address the long-standing “spring-boot-devtools” issue. (dep not included in the image)
- makes use of layering for fast rebuilds (as seen in dive inspect)
- dont have to worry about constructing a docker file (not that its too hard..)
- great option with Maven and Gradle builds for Container Images that use the `JVM`.

### Cons

- Only for jvm languages

## docker

```bash
docker build -t spring-boot-web:dockerfile .
docker run --rm -it -ePORT=8080 -p8080:8080 spring-boot-web:dockerfile
```

### Pros
- can use multi phase approach
- language agnostic
- great power comes great responsibility!

### Cons
- potentially a lack of consistency across our docker files
- not using correct layering or lightweight base images

## redoc cloud run deployment

```bash
gcloud run deploy redoc-greetings-api --project $PROJECT_ID --image gcr.io/$PROJECT_ID/redoc --platform managed --region us-central1 --port 80 --cpu 1 --memory 256Mi --concurrency 80 --timeout 300 --update-env-vars SPEC_URL=https://<CLOUD_RUN_SPRING_BOOT_BASE_URI>/swagger.yaml
```

## Resources
- [Jib faqs](https://github.com/GoogleContainerTools/jib/blob/master/docs/faq.md)
- [jibbing on cloud run](https://blog.shanelee.name/2020/08/29/jibbing-with-spring-boot-and-google-cloud-run/)
