#!/bin/bash

set -ex

sudo podman build -t silverblue-asahi:39 .
sudo podman push silverblue-asahi quay.io/ecurtin/silverblue-asahi
sudo podman push silverblue-asahi quay.io/ecurtin/silverblue-asahi:39

mkdir -p _build
mkdir -p _build/osbuild_store/{objects,refs,sources/org.osbuild.files,tmp}
mkdir -p _build/image_output
osbuild-mpp silverblue-asahi-container.mpp.yaml _build/silverblue-asahi-container.json
osbuild-mpp -I . -D image_type="ostree" -D arch="aarch64" -D distro_name="silverblue-asahi" -D target="asahi" silverblue-asahi-container.mpp.yaml _build/silverblue-asahi-container.aarch64.json
