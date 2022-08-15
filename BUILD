cc_library(
    name = "locator",
    hdrs = ["locator.h"],
    copts = ["-Werror"],
    include_prefix = "indexlib/document",
    visibility = ["//visibility:public"],
    alwayslink = True,
)

cc_library(
  name = "hello",
  srcs = glob(
    [
      "*.cpp",
    ],
  ),
  hdrs = glob(
    [
      "*.h",
    ],
    exclude = [
      "locator.h",
    ],
  ),
  include_prefix = "indexlib/document",
  visibility = ["//visibility:public"],
  deps = [
    ":locator",
  ],
  alwayslink = True,
)
