package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@package_bundle//file:packages.bzl", "packages")
load("@package_bundle_debian10//file:packages.bzl", packages_debian10 = "packages")

DISTRO_PACKAGES = {
    "_debian9": packages,
    "_debian10": packages_debian10,
}

# An image for C/C++ programs
[container_image(
    name = ("quarkus-native" if (not mode) else mode[1:]) + distro_suffix,
    base = "//base" + (mode if mode else ":base") + distro_suffix,
    debs = [
        DISTRO_PACKAGES[distro_suffix]["zlib1g"],
    ],
) for mode in [
    "",
    ":debug",
] for distro_suffix in ("_debian9", "_debian10")]

# Provide aliases so the default images use debian9
alias(
    name = "quarkus-native",
    actual = ":quarkus-native_debian9",
)

alias(
    name = "debug",
    actual = ":debug_debian9",
)
