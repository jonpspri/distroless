# Documentation for `gcr.io/distroless/quarkus-native`

## Image Contents

This image contains a minimal Linux, zlib1g runtime for binaries compiled as
[native executables](https://quarkus.io/guides/building-native-image) via
[quarkus](https://quarkus.io).

Specifically, the image contains everything in the [base image](../base/README.md), plus:

* zlib1g and its dependencies.

## Usage

Users are expected to include their compiled application and set the correct CMD in their image.
