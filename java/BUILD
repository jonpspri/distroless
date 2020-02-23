package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//java:image.bzl", "java_image")

load("@package_bundle_amd64//file:packages.bzl",
    packages_amd64 = "packages", versions_amd64 = "versions")
load("@package_bundle_arm64//file:packages.bzl",
    packages_arm64 = "packages", versions_arm64 = "versions")
load("@package_bundle_ppc64el//file:packages.bzl",
    packages_ppc64el = "packages", versions_ppc64el = "versions")
load("@package_bundle_s390x//file:packages.bzl",
    packages_s390x = "packages", versions_s390x = "versions")

load("@package_bundle_debian10_amd64//file:packages.bzl",
    packages_debian10_amd64 = "packages", versions_debian10_amd64 = "versions")
load("@package_bundle_debian10_arm64//file:packages.bzl",
    packages_debian10_arm64 = "packages", versions_debian10_arm64 = "versions")
load("@package_bundle_debian10_ppc64el//file:packages.bzl",
    packages_debian10_ppc64el = "packages", versions_debian10_ppc64el = "versions")
load("@package_bundle_debian10_s390x//file:packages.bzl",
    packages_debian10_s390x = "packages", versions_debian10_s390x = "versions")

load("//cacerts:java.bzl", "cacerts_java")
load("//java:jre_ver.bzl", "jre_ver")

DISTRO_SUFFIXES = ("_debian9", "_debian10")

DISTRO_PACKAGES = {
    "_debian9_amd64": packages_amd64,
    "_debian9_arm64": packages_arm64,
    "_debian9_ppc64le": packages_ppc64el,
    "_debian9_s390x": packages_s390x,
    "_debian10_amd64": packages_debian10_amd64,
    "_debian10_arm64": packages_debian10_arm64,
    "_debian10_ppc64le": packages_debian10_ppc64el,
    "_debian10_s390x": packages_debian10_s390x,
}

DISTRO_VERSIONS = {
    "_debian9_amd64": versions_amd64,
    "_debian9_arm64": versions_arm64,
    "_debian9_ppc64le": versions_ppc64el,
    "_debian9_s390x": versions_s390x,
    "_debian10_amd64": versions_debian10_amd64,
    "_debian10_arm64": versions_debian10_arm64,
    "_debian10_ppc64le": versions_debian10_ppc64el,
    "_debian10_s390x": versions_debian10_s390x,
}

cacerts_java(
    name = "cacerts_java",
)

[[container_image(
    name = rule_name + distro_suffix,
    base = ("//cc:cc" if (not ("debug" in rule_name)) else "//cc:debug") + distro_suffix,
    debs = [
        DISTRO_PACKAGES[distro_suffix]["zlib1g"],
        DISTRO_PACKAGES[distro_suffix]["libjpeg62-turbo"],
        DISTRO_PACKAGES[distro_suffix]["libpng16-16"],
        DISTRO_PACKAGES[distro_suffix]["liblcms2-2"],
        DISTRO_PACKAGES[distro_suffix]["libfreetype6"],
        DISTRO_PACKAGES[distro_suffix]["fonts-dejavu-core"],
        DISTRO_PACKAGES[distro_suffix]["fontconfig-config"],
        DISTRO_PACKAGES[distro_suffix]["libexpat1"],
        DISTRO_PACKAGES[distro_suffix]["libfontconfig1"],
    ] + [DISTRO_PACKAGES[distro_suffix][deb] for deb in java_debs],
    # We expect users to use:
    # cmd = ["/path/to/deploy.jar", "--option1", ...]
    entrypoint = [
        "/usr/bin/java",
        "-jar",
    ],
    env = {
        "JAVA_VERSION": jre_ver(DISTRO_VERSIONS[distro_suffix][java_debs[0]]),
    },
    symlinks = {
        "/usr/bin/java": java_executable_path,
    },
    tars = [":cacerts_java"],
) for (distro_suffix, rule_name, java_debs, java_executable_path) in [
    (
        "_debian9_"+arch,
        "java8",
        ["openjdk-8-jre-headless"],
        "/usr/lib/jvm/java-8-openjdk-{}/jre/bin/java".format(arch),
    ),
    (
        "_debian9_"+arch,
        "java8_debug",
        [
            "openjdk-8-jre-headless",
            "openjdk-8-jdk-headless",
        ],
        "/usr/lib/jvm/java-8-openjdk-{}/jre/bin/java".format(arch),
    ),
    (
        "_debian9_"+arch,
        "java11",
        ["openjdk-11-jre-headless"],
        "/usr/lib/jvm/java-11-openjdk-{}/bin/java".format(arch),
    ),
    (
        "_debian9_"+arch,
        "java11_debug",
        [
            "openjdk-11-jre-headless",
            "openjdk-11-jdk-headless",
        ],
        "/usr/lib/jvm/java-11-openjdk-{}/bin/java".format(arch),
    ),
    (
        "_debian10_"+arch,
        "java11",
        ["openjdk-11-jre-headless"],
        "/usr/lib/jvm/java-11-openjdk-{}/bin/java".format(arch),
    ),
    (
        "_debian10_"+arch,
        "java11_debug",
        [
            "openjdk-11-jre-headless",
            "openjdk-11-jdk-headless",
        ],
        "/usr/lib/jvm/java-11-openjdk-{}/bin/java".format(arch),
    ),
    (
        "_debian9_"+arch,
        "adoptopenjdk8",
        ["adoptopenjdk-8-hotspot-jre"],
        "/usr/lib/jvm/adoptopenjdk-8-hotspot-jre-{}/bin/java".format(arch),
    ),
    (
        "_debian10_"+arch,
        "adoptopenjdk8",
        ["adoptopenjdk-8-hotspot-jre"],
        "/usr/lib/jvm/adoptopenjdk-8-hotspot-jre-{}/bin/java".format(arch),
    ),
    (
        "_debian9_"+arch,
        "adoptopenjdk8_debug",
        ["adoptopenjdk-8-hotspot"],
        "/usr/lib/jvm/adoptopenjdk-8-hotspot-{}/bin/java".format(arch),
    ),
    (
        "_debian10_"+arch,
        "adoptopenjdk8_debug",
        ["adoptopenjdk-8-hotspot"],
        "/usr/lib/jvm/adoptopenjdk-8-hotspot-{}/bin/java".format(arch),
    ),
    (
        "_debian9_"+arch,
        "adoptopenjdk11",
        ["adoptopenjdk-11-hotspot-jre"],
        "/usr/lib/jvm/adoptopenjdk-11-hotspot-jre-{}/bin/java".format(arch),
    ),
    (
        "_debian10_"+arch,
        "adoptopenjdk11",
        ["adoptopenjdk-11-hotspot-jre"],
        "/usr/lib/jvm/adoptopenjdk-11-hotspot-jre-{}/bin/java".format(arch),
    ),
    (
        "_debian9_"+arch,
        "adoptopenjdk11_debug",
        ["adoptopenjdk-11-hotspot"],
        "/usr/lib/jvm/adoptopenjdk-11-hotspot-{}/bin/java".format(arch),
    ),
    (
        "_debian10_"+arch,
        "adoptopenjdk11_debug",
        ["adoptopenjdk-11-hotspot"],
        "/usr/lib/jvm/adoptopenjdk-11-hotspot-{}/bin/java".format(arch),
    ),
]] for arch in [ "amd64", "arm64", "ppc64le", "s390x" ]]

# Provide aliases so the default images use debian9
alias(
    name = "java8",
    actual = ":java8_debian9_amd64",
)

alias(
    name = "java8_debug",
    actual = ":java8_debug_debian9_amd64",
)

alias(
    name = "java11",
    actual = ":java11_debian9_amd64",
)

alias(
    name = "java11_debug",
    actual = ":java11_debug_debian9_amd64",
)

# container_test(
#     name = "java8_debian9_test",
#     configs = ["testdata/java8.yaml"],
#     image = ":java8_debian9_amd64",
# )
#
# container_test(
#     name = "java8_debug_debian9_test",
#     configs = ["testdata/java8_debug.yaml"],
#     image = ":java8_debug_debian9_amd64",
# )
#
# [container_test(
#     name = "java11" + distro_suffix + "_test",
#     configs = ["testdata/java11.yaml"],
#     image = ":java11" + distro_suffix,
# ) for distro_suffix in DISTRO_SUFFIXES]
#
# [container_test(
#     name = "java11_debug" + distro_suffix + "_test",
#     configs = ["testdata/java11_debug.yaml"],
#     image = ":java11_debug" + distro_suffix,
# ) for distro_suffix in DISTRO_SUFFIXES]
#
# java_image(
#     name = "check_certs_java8_debian9",
#     srcs = ["testdata/CheckCerts.java"],
#     base = "//java:java8_debian9",
#     main_class = "testdata.CheckCerts",
# )
#
# [java_image(
#     name = "check_certs_java11" + distro_suffix,
#     srcs = ["testdata/CheckCerts.java"],
#     base = "//java:java11" + distro_suffix,
#     main_class = "testdata.CheckCerts",
# ) for distro_suffix in DISTRO_SUFFIXES]
#
# container_test(
#     name = "check_certs_java8_debian9_test",
#     configs = ["testdata/java8_certs.yaml"],
#     image = ":check_certs_java8_debian9",
# )
#
# [container_test(
#     name = "check_certs_java11" + distro_suffix + "_test",
#     configs = ["testdata/java11_certs" + distro_suffix + ".yaml"],
#     image = ":check_certs_java11" + distro_suffix,
# ) for distro_suffix in DISTRO_SUFFIXES]
