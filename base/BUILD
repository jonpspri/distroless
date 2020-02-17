package(default_visibility = ["//visibility:public"])

load(":base.bzl", "NONROOT", "distro_components")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@io_bazel_rules_docker//contrib:group.bzl", "group_entry", "group_file")
load("@io_bazel_rules_docker//contrib:passwd.bzl", "passwd_entry", "passwd_tar")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_go//go:def.bzl", "go_binary")

NOBODY = 65534

# Create /etc/passwd with the root user
passwd_entry(
    name = "root_user",
    gid = 0,
    home = "/root",
    info = "root",
    shell = "/sbin/nologin",
    uid = 0,
    username = "root",
)

passwd_entry(
    name = "nobody_user",
    create_home = False,
    gid = NOBODY,
    home = "/nonexistent",
    info = "nobody",
    shell = "/sbin/nologin",
    uid = NOBODY,
    username = "nobody",
)

passwd_entry(
    name = "nonroot_user",
    gid = NONROOT,
    home = "/home/nonroot",
    info = "nonroot",
    shell = "/sbin/nologin",
    uid = NONROOT,
    username = "nonroot",
)

passwd_tar(
    name = "passwd",
    entries = [
        ":root_user",
        ":nobody_user",
        ":nonroot_user",
    ],
    passwd_file_pkg_dir = "etc",
)

# Create /etc/group with the root, tty, and staff groups
group_entry(
    name = "root_group",
    gid = 0,
    groupname = "root",
)

group_entry(
    name = "nobody_group",
    gid = NOBODY,
    groupname = "nobody",
)

group_entry(
    name = "nonroot_group",
    gid = NONROOT,
    groupname = "nonroot",
)

group_entry(
    name = "tty_group",
    gid = 5,
    groupname = "tty",
)

group_entry(
    name = "staff_group",
    gid = 50,
    groupname = "staff",
)

group_file(
    name = "group",
    entries = [
        ":root_group",
        ":nobody_group",
        ":tty_group",
        ":staff_group",
        ":nonroot_group",
    ],
)

pkg_tar(
    name = "group_tar",
    srcs = [":group"],
    mode = "0644",
    package_dir = "etc",
)

load("@package_bundle_amd64//file:packages.bzl", packages_amd64 = "packages")
load("@package_bundle_arm64//file:packages.bzl", packages_arm64 = "packages")
load("@package_bundle_ppc64el//file:packages.bzl", packages_ppc64el = "packages")
load("@package_bundle_s390x//file:packages.bzl", packages_s390x = "packages")

load("@package_bundle_debian10_amd64//file:packages.bzl", packages_debian10_amd64 = "packages")
load("@package_bundle_debian10_arm64//file:packages.bzl", packages_debian10_arm64 = "packages")
load("@package_bundle_debian10_ppc64el//file:packages.bzl", packages_debian10_pcc64el = "packages")
load("@package_bundle_debian10_s390x//file:packages.bzl", packages_debian10_s390x = "packages")

load("//cacerts:cacerts.bzl", "cacerts")

go_binary(
    name = "check_certs",
    srcs = ["testdata/check_certs.go"],
    # Test image is linux based
    goos = "linux",
    pure = "on",
)
arch_list = [ "amd64", "arm64", "ppc64le", "s390x" ]

# Replicate the containers and tests for debian9 and debian10
[ distro_components("_debian9_"+ arch) for arch in arch_list ]
[ distro_components("_debian10_"+ arch) for arch in arch_list ]

# alias debian9 as the default images
alias(
    name = "static",
    actual = ":static_debian9_amd64",
)

alias(
    name = "static-nonroot",
    actual = ":static-nonroot_debian9_amd64",
)

alias(
    name = "base",
    actual = ":base_debian9_amd64",
)

alias(
    name = "base-nonroot",
    actual = ":base-nonroot_debian9_amd64",
)

alias(
    name = "debug",
    actual = ":debug_debian9_amd64",
)

alias(
    name = "debug-nonroot",
    actual = ":debug-nonroot_debian9_amd64",
)
