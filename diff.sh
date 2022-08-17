#!/bin/bash
set -x
prefix=$@

cp /home/admin/undeclared_inclusion/aios/storage/indexlib/indexlib/BUILD1 /home/admin/undeclared_inclusion/aios/storage/indexlib/indexlib/BUILD
bazel clean
bazel build -s :hello --config=clang --config=debug --config=remote --noremote_accept_cached --remote_executor=grpc://100.69.120.2:8989 --experimental_remote_grpc_log=$HOME/remote.log 
sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.1
(cd $HOME/tools_remote && bazel-bin/remote_client --grpc_log $HOME/remote.log printlog > /tmp/${prefix}remote1.log)


cp /home/admin/undeclared_inclusion/aios/storage/indexlib/indexlib/BUILD2 /home/admin/undeclared_inclusion/aios/storage/indexlib/indexlib/BUILD
bazel build -s :hello --config=clang --config=debug --config=remote --remote_accept_cached --remote_executor=grpc://100.69.120.2:8989 --experimental_remote_grpc_log=$HOME/remote.log
sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.2
(cd $HOME/tools_remote && bazel-bin/remote_client --grpc_log $HOME/remote.log printlog > /tmp/${prefix}remote2.log)

#bazel clean
#bazel --noworkspace_rc build -s :hello --remote_accept_cached --remote_executor=grpc://100.69.120.2:8989
#sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.3

diff /tmp/${prefix}hello.pic.d.1 /tmp/${prefix}hello.pic.d.2
#diff /tmp/${prefix}hello.pic.d.2 /tmp/${prefix}hello.pic.d.3
