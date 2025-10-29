# docker-in-docker-in-docker

"docker run --rm -v $(pwd):/src emscripten/emsdk:latest ./build.sh"

```
docker run -it --rm --entrypoint bash "$(docker buildx build --allow security.insecure .)"
```

```
docker run --entrypoint bash my_image
```

```
docker run -it --rm --privileged my_image
```

```
docker run -it --rm --privileged my_image
```

```
docker buildx build --no-cache --progress=plain --builder insecure-builder --allow security.insecure .
docker buildx build --allow security.insecure .
```

```
docker run -it --rm --privileged $(docker buildx build --allow security.insecure .)
```

```
docker buildx create --use --name insecure-builder --buildkitd-flags "--allow-insecure-entitlement security.insecure"
docker run -it --rm --privileged $(docker buildx build --builder insecure-builder --allow security.insecure .)

```
