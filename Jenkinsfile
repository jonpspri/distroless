/*
 * This file makes two assumptions about your Jenkins build environment:
 *
 * 1.  You have nodes set up with labels of the form "docker-${ARCH}" to
 *     support the various build architectures (currently 'x86_64',
 *     's390x', 'aarch64' (ARM), and 'ppc64le').
 * 2.  If you do not want to target the 'docker.io/openwhisk' registry
 *     (and unless you're the official maintainer, you shouldn't), then
 *     you've set up an OPENWHISK_TARGET_REGISTRY variable with the target
 *     registry you'll use.
 *
 * TODO: Set up the build architectures as a parameter that will drive
 *       a scripted loop to build stages.
 */

def build_shell='''
registry=${OPENWHISK_TARGET_REGISTRY:-docker.io}
prefix=${OPENWHISK_TARGET_PREFIX:-s390xopenwhisk}
arch=$(uname -m)

./workspace.sh
bazel run --host_force_python=PY2 //${IMAGE}
docker tag "bazel/${IMAGE}" \
  ${registry}/${prefix}/${IMAGE}-${arch}
'''

def manifest_shell='''
registry=${OPENWHISK_TARGET_REGISTRY:-docker.io}
prefix=${OPENWHISK_TARGET_PREFIX:-openwhisk}
rm -rf ~/.docker/manifests
i=${image:-base:static_debian9}
docker manifest create ${registry}/${prefix}/$i \
    ${registry}/${prefix}/$i-x86_64 \
    ${registry}/${prefix}/$i-s390x \
    ${registry}/${prefix}/$i-aarch64 \
    ${registry}/${prefix}/$i-ppc64le
docker manifest annotate --os linux --arch amd64 \
    ${registry}/${prefix}/$i \
    ${registry}/${prefix}/$i-x86_64
docker manifest annotate --os linux --arch s390x \
    ${registry}/${prefix}/$i \
    ${registry}/${prefix}/$i-s390x
docker manifest annotate --os linux --arch arm64 \
    ${registry}/${prefix}/$i \
    ${registry}/${prefix}/$i-aarch64
docker manifest annotate --os linux --arch ppc64le \
    ${registry}/${prefix}/$i \
    ${registry}/${prefix}/$i-ppc64le
docker manifest push ${registry}/${prefix}/$i
'''

pipeline {
  agent none
  stages {
    stage('Build (Outer)') {
      matrix {
        axes {
            axis {
                name 'ARCH'
                values 'x86_64','s390x','aarch64','ppc64le'
            }
            axis {
                name 'TARGET'
                values 'base:static_debian9'
            }
        }
        stages {
            stage("Build") {
                agent {
                    label "docker-${ARCH}"
                }
                environment {
                  IMAGE = "${TARGET}"
                }
                steps {
                    sh build_shell
                }
            }
        }
      }
    }
    /* stage("Manifest") {
      agent {
        // Could be anything capable of running 'docker manifest', but right
        // now only the x86_64 environment is set up for that.
       label "docker-x86_64"
      }
      steps {
        sh manifest_shell
      }
    } */
  }
}
