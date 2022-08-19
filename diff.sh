#!/bin/bash
set -x

cp $PWD/aios/storage/indexlib/indexlib/BUILD1 $PWD/aios/storage/indexlib/indexlib/BUILD
bazel clean
bazel build -s :hello --noremote_accept_cached --remote_executor=grpc://localhost:8980 --experimental_remote_grpc_log=$HOME/remote.log 
sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.1
# (cd $HOME/tools_remote && bazel-bin/remote_client --grpc_log $HOME/remote.log printlog > /tmp/remote1.log)

cp $PWD/aios/storage/indexlib/indexlib/BUILD2 $PWD/aios/storage/indexlib/indexlib/BUILD
bazel build -s :hello --noremote_accept_cached --remote_executor=grpc://localhost:8980 --experimental_remote_grpc_log=$HOME/remote.log
sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.2
#(cd $HOME/tools_remote && bazel-bin/remote_client --grpc_log $HOME/remote.log printlog > /tmp/${prefix}remote2.log)

diff /tmp/${prefix}hello.pic.d.1 /tmp/${prefix}hello.pic.d.2
