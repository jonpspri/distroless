def build_shell='''
registry=${OPENWHISK_TARGET_REGISTRY:-docker.io}
prefix=${OPENWHISK_TARGET_PREFIX:-s390xopenwhisk}
target=${TARGET:-"base:static_debian9"}

# Fully qualified image (to make our script more terse)
fq_image=${registry}/${prefix}/${target}

mkdir -p ${WORKSPACE}/${target}

for arch in amd64 arm64v8 ppc64le s390x; do
  bazel --output_base="${WORKSPACE}/${target}/output_base" \
    run --host_force_python=PY2 "//${target}_${arch}"
  docker tag bazel/${target}_${arch} ${fq_image}_${arch}
  docker push ${fq_image}_${arch}
done

cp -R ${HOME}/.docker ${WORKSPACE}/${target}/
rm -rf ${WORKSPACE}/${TARGET}_${ARCH}/.docker/manifests

docker --config ${WORKSPACE}/${target}/.docker \
  manifest create ${fq_image} \
  ${fq_image}_amd64 \
  ${fq_image}_arm64v8 \
  ${fq_image}_ppc64le \
  ${fq_image}_s390x

for arch in amd64 arm64v8 ppc64le s390x; do
  docker --config ${WORKSPACE}/${target}/.docker \
    manifest annotate --os linux --arch ${arch} \
    ${fq_image} ${fq_image}_${arch}
done

docker --config ${WORKSPACE}/${target}/.docker \
  manifest push ${fq_image}
'''

pipeline {
  agent { label "docker-bazel" }
  stages {
    stage('Matrix') {
      matrix {
        axes {
            axis {
                name 'BAZEL_TARGET'
                values 'base:base', 'base:static'
            }
            axis {
                name 'DEBIAN_RELEASE'
                values 'debian9', 'debian10'
            }
        }
        stages {
            stage("Build") {
                environment { 
                  TARGET = "${BAZEL_TARGET}_${DEBIAN_RELEASE}" 
                }
                steps { sh build_shell }
            }
        }
      }
    }
  }
}
