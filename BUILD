cc_library(
  name = "hello",
  srcs = glob(
    [
      "hello.cc",
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
  deps = [
    ":locator",
  ],
  include_prefix = "indexlib/document",
)

cc_library(
    name = "locator",
    hdrs = ["locator.h"],
    include_prefix = "indexlib/document",
)
