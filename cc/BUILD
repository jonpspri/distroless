package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")

load("@package_bundle_amd64//file:packages.bzl", packages_amd64 = "packages")
load("@package_bundle_arm64//file:packages.bzl", packages_arm64 = "packages")
load("@package_bundle_ppc64el//file:packages.bzl", packages_ppc64el = "packages")
load("@package_bundle_s390x//file:packages.bzl", packages_s390x = "packages")

load("@package_bundle_debian10_amd64//file:packages.bzl", packages_debian10_amd64 = "packages")
load("@package_bundle_debian10_arm64//file:packages.bzl", packages_debian10_arm64 = "packages")
load("@package_bundle_debian10_ppc64el//file:packages.bzl", packages_debian10_ppc64el = "packages")
load("@package_bundle_debian10_s390x//file:packages.bzl", packages_debian10_s390x = "packages")

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

# An image for C/C++ programs
[[container_image(
    name = ("cc" if (not mode) else mode[1:]) + distro_suffix,
    base = "//base" + (mode if mode else ":base") + distro_suffix,
    debs = [
        DISTRO_PACKAGES[distro_suffix]["libgcc1"],
        DISTRO_PACKAGES[distro_suffix]["libgomp1"],
        DISTRO_PACKAGES[distro_suffix]["libstdc++6"],
    ],
) for mode in [
    "",
    ":debug",
]] for distro_suffix in (
    "_debian9_amd64", "_debian9_arm64", "_debian9_ppc64le", "_debian9_s390x",
    "_debian10_amd64", "_debian10_arm64", "_debian10_ppc64le", "_debian10_s390x"
)]

# Provide aliases so the default images use debian9
alias(
    name = "cc",
    actual = ":cc_debian9_amd64",
)

alias(
    name = "debug",
    actual = ":debug_debian9_amd64",
)
