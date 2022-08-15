#!/bin/bash
set -x
prefix=$@

cp BUILD1 BUILD
bazel clean
bazel --noworkspace_rc build -s :hello --noremote_accept_cached
sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.1

cp BUILD2 BUILD
bazel --noworkspace_rc build -s :hello --noremote_accept_cached
sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.2

bazel clean
bazel --noworkspace_rc build -s :hello --remote_accept_cached
sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.3

diff /tmp/${prefix}hello.pic.d.1 /tmp/${prefix}hello.pic.d.2
diff /tmp/${prefix}hello.pic.d.2 /tmp/${prefix}hello.pic.d.3
