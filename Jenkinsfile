def build_shell='''
registry=${OPENWHISK_TARGET_REGISTRY:-docker.io}
prefix=${OPENWHISK_TARGET_PREFIX:-s390xopenwhisk}
target=${TARGET:-"base:static_debian9"}
image=${target%%:*}
base=${target##*:}

for arch in amd64 arm64v8 ppc64le s390x; do
  bazel run --host_force_python=PY2 "//${target}_${arch}"
done

rm -rf ~/.docker/manifests  # DANGEROUS

docker manifest create ${registry}/${prefix}/${target} \
  bazel/${target}_amd64 \
  bazel/${target}_arm64v8 \
  bazel/${target}_ppc64le \
  bazel/${target}_s390x

for arch in amd64 arm64v8 ppc64le s390x; do
  docker manifest annotate --os linux --arch ${arch} \
    ${registry}/${prefix}/${target} bazel/${target}_${arch}
done

docker manifest push ${registry}/${prefix}/$i
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
