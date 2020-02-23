#!/usr/bin/env sh

set -ue

registry=${TARGET_REGISTRY:-docker.io}
prefix=${TARGET_PREFIX:-springjp}
name_prefix=${IMAGE_NAME_PREIX:-distroless_}

rm -rf $HOME/.docker/manifests/*

for target in \
    base:base_debian9 base:base_debian10 \
    base:base-nonroot_debian9 base:base-nonroot_debian10 \
    base:static_debian9 base:static_debian10 \
    base:static-nonroot_debian9 base:static-nonroot_debian10 \
    cc:cc_debian9 cc:cc_debian10 \
    java:java8_debian9 java:java11_debian10 \
    java:adoptopenjdk8_debian9 java:adoptopenjdk8_debian10 \
    java:adoptopenjdk11_debian9 java:adoptopenjdk11_debian10
do (
    # Fully qualified image (to make our script more terse)
    fq_image=${registry}/${prefix}/${name_prefix}${target}

    for arch in amd64 arm64 ppc64le s390x; do
      bazel run --host_force_python=PY2 "//${target}_${arch}"
      docker tag "bazel/${target}_${arch}" "${fq_image}_${arch}"
      docker push "${fq_image}_${arch}"
    done

    docker manifest create "${fq_image}" \
          "${fq_image}_amd64" \
          "${fq_image}_arm64" \
          "${fq_image}_ppc64le" \
          "${fq_image}_s390x"

    for arch in amd64 arm64 ppc64le s390x; do
      docker manifest annotate --os linux --arch ${arch} \
        "${fq_image}" "${fq_image}_${arch}"
    done

    docker manifest push --purge "${fq_image}"
) done
