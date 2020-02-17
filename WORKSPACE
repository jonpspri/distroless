workspace(name = "distroless")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "8df59f11fb697743cbb3f26cfb8750395f30471e9eabde0d174c3aebc7a1cd39",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/rules_go/releases/download/0.19.1/rules_go-0.19.1.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/0.19.1/rules_go-0.19.1.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains()

load("//package_manager:package_manager.bzl", "package_manager_repositories")
load("//package_manager:dpkg.bzl", "dpkg_list", "dpkg_src")

package_manager_repositories()

arch_list = [ "amd64", "arm64", "ppc64el", "s390x" ]

debian_stretch_sha256 = {
  "amd64": "2b13362808b7bd90d24db2e0804c799288694ae44bd7e3d123becc191451fc67",
  "arm64": "a76c6af805f06aad4ddd57e4252a9936896b805b8de7886de7b0030b2fcd44bb",
  "ppc64el": "244d2268bbad2299500b1bd24a993e2f6c9e4a6b92ba60df782e20aa4be88273",
  "s390x": "38b8c6157ecc39caeb44eb2d2006e63a2f0297a314b3186a993c2e24c32b816d",
}

[ dpkg_src(
    name = "debian_stretch_" + arch,
    arch = arch,
    distro = "stretch",
    sha256 = debian_stretch_sha256[arch],
    snapshot = "20191230T150135Z",
    url = "https://snapshot.debian.org/archive",
) for arch in arch_list ]

debian_stretch_backports_sha256 = {
  "amd64": "ca26befa30c4cef5900e28ced7baf2f237b4d02550e00823e8c3967cb1615f8c",
  "arm64": "27dad12dc733b77c739dad8bc257745fed1eb74e8080e9ec19098f7a3f91dd21",
  "ppc64el": "2e088a1dedfb7a9c7fe88505786a4e42f9437648431d68c09e9b7082ce6ab7cd",
  "s390x": "fa396ee1a76095f2a13f53f5c01d5ac90455356274bff25df57499ce52254f84",
}

[ dpkg_src(
    name = "debian_stretch_backports_" + arch,
    arch = arch,
    distro = "stretch-backports",
    sha256 = debian_stretch_backports_sha256[arch],
    snapshot = "20191230T150135Z",
    url = "https://snapshot.debian.org/archive",
) for arch in arch_list ]

debian_stretch_security_sha256 = {
  "amd64": "046a277f34b07c723f363f132eb6cb3485f25170ae426bc3ef146968b259f585",
  "arm64": "b6acb4bbcdb99c840c7e3805b75f467fe09ac04f904c8c6433bd7bc87df784a5",
  "ppc64el": "74a40f2bdb472fd6a0d6bce5301c13cf60c1c8aad6992db428e83c31590c38c2",
  "s390x": "191ac3d81779ce39457cf94c69a8ff25b43b3db0e5d9fcd3cf878c4b12a47534",
}

[ dpkg_src(
    name = "debian_stretch_security_" + arch,
    package_prefix = "https://snapshot.debian.org/archive/debian-security/20191230T212302Z/",
    packages_gz_url = "https://snapshot.debian.org/archive/debian-security/20191230T212302Z/dists/stretch/updates/main/binary-" + arch + "/Packages.gz",
    sha256 = debian_stretch_security_sha256[arch],
) for arch in arch_list ]

[ dpkg_list(
    name = "package_bundle_"+arch,
    packages = [
        # Version required to skip a security fix to the pre-release library
        # TODO: Remove when there is a security fix or dpkg_list finds the recent version
        "libc6=2.24-11+deb9u4",
        "base-files",
        "ca-certificates",
        "openssl",
        "libssl1.0.2",
        "libssl1.1",
        "libbz2-1.0",
        "libdb5.3",
        "libffi6",
        "libncursesw5",
        "liblzma5",
        "libexpat1",
        "libreadline7",
        "libtinfo5",
        "libsqlite3-0",
        "mime-support",
        "netbase",
        "readline-common",
        "tzdata",

        #c++
        "libgcc1",
        "libgomp1",
        "libstdc++6",

        #java
        "zlib1g",
        "libjpeg62-turbo",
        "libpng16-16",
        "liblcms2-2",
        "libfreetype6",
        "fonts-dejavu-core",
        "fontconfig-config",
        "libfontconfig1",
        "openjdk-8-jre-headless",
        "openjdk-8-jdk-headless",
        "openjdk-11-jre-headless",
        "openjdk-11-jdk-headless",

        #python
        "libpython2.7-minimal",
        "python2.7-minimal",
        "libpython2.7-stdlib",
        "dash",
        # Version required to skip a security fix to the pre-release library
        # TODO: Remove when there is a security fix or dpkg_list finds the recent version
        "libc-bin=2.24-11+deb9u4",

        #python3
        "libmpdec2",
        "libpython3.5-minimal",
        "libpython3.5-stdlib",
        "python3.5-minimal",

        #dotnet
        # "libcurl3",
        # "libgssapi-krb5-2",
        # "libicu57",
        # "liblttng-ust0",
        # "libssl1.0.2",
        # "libunwind8",
        # "libuuid1",
        # "zlib1g",
        # "curl",
        # "libcomerr2",
        # "libidn2-0",
        # "libk5crypto3",
        # "libkrb5-3",
        # "libldap-2.4-2",
        # "libldap-common",
        # "libsasl2-2",
        # "libnghttp2-14",
        # "libpsl5",
        # "librtmp1",
        # "libssh2-1",
        # "libkeyutils1",
        # "libkrb5support0",
        # "libunistring0",
        # "libgnutls30",
        # "libgmp10",
        # "libhogweed4",
        # "libidn11",
        # "libnettle6",
        # "libp11-kit0",
        # "libffi6",
        # "libtasn1-6",
        # "libsasl2-modules-db",
        # "libgcrypt20",
        # "libgpg-error0",
        # "libacl1",
        # "libattr1",
        # "libselinux1",
        # "libpcre3",
        # "libbz2-1.0",
        # "liblzma5",
    ],
    # Takes the first package found: security updates should go first
    # If there was a security fix to a package before the stable release, this will find
    # the older security release. This happened for stretch libc6.
    sources = [
        "@debian_stretch_security_"+arch+"//file:Packages.json",
        "@debian_stretch_backports_"+arch+"//file:Packages.json",
        "@debian_stretch_"+arch+"//file:Packages.json",
    ],
) for arch in arch_list ]

# For Jetty
http_archive(
    name = "jetty",
    build_file = "//:BUILD.jetty",
    sha256 = "1b9ec532cd9b94550fad655e066a1f9cc2d350a1c79daea85d5c56fdbcd9aaa8",
    strip_prefix = "jetty-distribution-9.4.22.v20191022/",
    type = "tar.gz",
    urls = ["https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.22.v20191022/jetty-distribution-9.4.22.v20191022.tar.gz"],
)

# Node
http_archive(
    name = "nodejs",
    build_file = "//experimental/nodejs:BUILD.nodejs",
    sha256 = "417bdc5402f6510fe1a5a898a9cdf1d67bd0202b5f014051c382f05358999534",
    strip_prefix = "node-v10.17.0-linux-x64/",
    type = "tar.gz",
    urls = ["https://nodejs.org/dist/v10.17.0/node-v10.17.0-linux-x64.tar.gz"],
)

# dotnet
http_archive(
    name = "dotnet",
    build_file = "//experimental/dotnet:BUILD.dotnet",
    sha256 = "69ecad24bce4f2132e0db616b49e2c35487d13e3c379dabc3ec860662467b714",
    type = "tar.gz",
    urls = ["https://download.microsoft.com/download/5/F/0/5F0362BD-7D0A-4A9D-9BF9-022C6B15B04D/dotnet-runtime-2.0.0-linux-x64.tar.gz"],
)

# For the debug image
http_file(
    name = "busybox",
    executable = True,
    sha256 = "d922ebe9067d8ed1b2b9cf326776de40a9b23d4518d674e28a3c14181549d28b",
    urls = ["https://busybox.net/downloads/binaries/1.31.0-i686-uclibc/busybox"],
)

# Docker rules.
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "413bb1ec0895a8d3249a01edf24b82fd06af3c8633c9fb833a0cb1d4b234d46d",
    strip_prefix = "rules_docker-0.12.0",
    urls = ["https://github.com/bazelbuild/rules_docker/archive/v0.12.0.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

# Used to generate java ca certs.
container_pull(
    name = "debian9",
    # From tag: 2019-02-27-130449
    digest = "sha256:fd26dfa474b76ef931e439537daba90bbd90d6c5bbdd0252616e6d87251cd9cd",
    registry = "gcr.io",
    repository = "google-appengine/debian9",
)

# Have the py_image dependencies for testing.
load(
    "@io_bazel_rules_docker//python:image.bzl",
    _py_image_repos = "repositories",
)

_py_image_repos()

# Have the java_image dependencies for testing.
load(
    "@io_bazel_rules_docker//java:image.bzl",
    _java_image_repos = "repositories",
)

_java_image_repos()

# Have the go_image dependencies for testing.
load(
    "@io_bazel_rules_docker//go:image.bzl",
    _go_image_repos = "repositories",
)

_go_image_repos()

debian10_sha256 = {
  "amd64": "6f21fb3369b618a55bac745bff10835ac96ec1a7d8ec709029c7e9f0fa44ad25",
  "arm64": "0a522d38cbae065a28fa8cca6f45e3e1d2a05b37e551222323d48f9bdbd35253",
  "ppc64el": "f50626b7925bfc9ea776746975633680adc6c0fc7d9f44781bc62eaa32171601",
  "s390x": "5d1a9406efbd36131266a2807c1024828a2e153842c1dae29e067082029a4444",
}

[ dpkg_src(
    name = "debian10_" + arch,
    arch = arch,
    distro = "buster",
    sha256 = debian10_sha256[arch],
    snapshot = "20191230T150135Z",
    url = "https://snapshot.debian.org/archive",
) for arch in arch_list ]

[ dpkg_list(
    name = "package_bundle_debian10_"+arch,
    packages = [
        "libc6",
        "base-files",
        "ca-certificates",
        "openssl",
        "libssl1.1",
        "libbz2-1.0",
        "libdb5.3",
        "libffi6",
        "liblzma5",
        "libexpat1",
        "libreadline7",
        "libsqlite3-0",
        "mime-support",
        "netbase",
        "readline-common",
        "tzdata",

        #c++
        "libgcc1",
        "libgomp1",
        "libstdc++6",

        #java
        "zlib1g",
        "libjpeg62-turbo",
        "libpng16-16",
        "liblcms2-2",
        "libfreetype6",
        "fonts-dejavu-core",
        "fontconfig-config",
        "libfontconfig1",
        "openjdk-11-jre-headless",
        "openjdk-11-jdk-headless",

        #python
        "dash",
        "libc-bin",
        "libpython2.7-minimal",
        "libpython2.7-stdlib",
        "python2.7-minimal",

        #python3
        "libmpdec2",
        "libpython3.7-minimal",
        "libpython3.7-stdlib",
        "libtinfo6",
        "libuuid1",
        "libncursesw6",
        "python3-distutils",
        "python3.7-minimal",

        #dotnet
        # "libcurl3",
        # "libgssapi-krb5-2",
        # "libicu57",
        # "liblttng-ust0",
        # "libssl1.0.2",
        # "libunwind8",
        # "libuuid1",
        # "zlib1g",
        # "curl",
        # "libcomerr2",
        # "libidn2-0",
        # "libk5crypto3",
        # "libkrb5-3",
        # "libldap-2.4-2",
        # "libldap-common",
        # "libsasl2-2",
        # "libnghttp2-14",
        # "libpsl5",
        # "librtmp1",
        # "libssh2-1",
        # "libkeyutils1",
        # "libkrb5support0",
        # "libunistring0",
        # "libgnutls30",
        # "libgmp10",
        # "libhogweed4",
        # "libidn11",
        # "libnettle6",
        # "libp11-kit0",
        # "libffi6",
        # "libtasn1-6",
        # "libsasl2-modules-db",
        # "libgcrypt20",
        # "libgpg-error0",
        # "libacl1",
        # "libattr1",
        # "libselinux1",
        # "libpcre3",
        # "libbz2-1.0",
        # "liblzma5",
    ],
    # Takes the first package found: security updates should go first
    # If there was a security fix to a package before the stable release, this will find
    # the older security release. This happened for stretch libc6.
    sources = [
        "@debian10_security_"+arch+"//file:Packages.json",
        "@debian10_"+arch+"//file:Packages.json",
    ],
) for arch in arch_list ]

debian10_security_sha256 = {
  "amd64": "20299ed97c71f26e6c34d948a358e3ac9bb9f4709a90b6f38e6094b688f5270b",
  "arm64": "fd32e56b0c5217a9ac5b723c2c2ae4587051ef22cbb2ebf1d5900222cb820033",
  "ppc64el": "13bfee6c515bd3b45491508b247d79ac34006ecbc65f1fa495ec461ca6f96721",
  "s390x": "c4adfd578ffd20a4c19d75dac1122b700b1e2879562be14188f54d15702e7212",
}

[ dpkg_src(
    name = "debian10_security_"+arch,
    package_prefix = "https://snapshot.debian.org/archive/debian-security/20191230T212302Z/",
    packages_gz_url = "https://snapshot.debian.org/archive/debian-security/20191230T212302Z/dists/buster/updates/main/binary-"+arch+"/Packages.gz",
    sha256 = debian10_security_sha256[arch],
) for arch in arch_list ]
