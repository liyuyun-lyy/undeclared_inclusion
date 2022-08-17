#!/bin/bash
set -x
prefix=$@

cp BUILD1 BUILD
bazel clean
#bazel build -s :hello --noremote_accept_cached --execution_log_binary_file=/tmp/${prefix}exec1.log --experimental_remote_grpc_log=$HOME/remote.log
bazel build -s :hello --execution_log_json_file=/tmp/${prefix}exec1.log --experimental_remote_grpc_log=$HOME/remote.log
sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.1
(cd $HOME/tools_remote && bazel-bin/remote_client --grpc_log $HOME/remote.log printlog > /tmp/${prefix}remote1.log)

cp BUILD2 BUILD
#bazel build -s :hello --noremote_accept_cached --execution_log_binary_file=/tmp/${prefix}exec2.log --experimental_remote_grpc_log=$HOME/remote.log
bazel build -s :hello --execution_log_binary_file=/tmp/${prefix}exec2.log --experimental_remote_grpc_log=$HOME/remote.log
sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.2
(cd $HOME/tools_remote && bazel-bin/remote_client --grpc_log $HOME/remote.log printlog > /tmp/${prefix}remote2.log)

#bazel clean
#bazel build -s :hello --remote_accept_cached
#sudo cp bazel-out/k8-fastbuild/bin/_objs/hello/hello.pic.d /tmp/${prefix}hello.pic.d.3

diff /tmp/${prefix}hello.pic.d.1 /tmp/${prefix}hello.pic.d.2
diff /tmp/${prefix}exec1.log.txt /tmp/${prefix}exec2.log.txt
diff /tmp/${prefix}remote1.log /tmp/${prefix}remote2.log
#diff /tmp/${prefix}hello.pic.d.2 /tmp/${prefix}hello.pic.d.3
