#!/bin/bash

export IMAGE_NAME=${IMAGE_NAME:-'docker-jsonnet'}
export VERSION=0.15.0

goal_build() {
  docker build . -t "${IMAGE_NAME}"
}

test_binary() {
  binary=$1
  received=$(docker run --privileged --rm -it "${IMAGE_NAME}" sh -c "$binary -v")
  if [[ $received =~ .*$VERSION.* ]]; then
    exit 0
  else
    echo "expected[$VERSION] did not match actual version ${received} for ${binary}"
    exit 1
  fi
}

goal_test() {
  test_binary jsonnet
  test_binary jsonnetfmt
}

goal_publish() {
  docker push "${IMAGE_NAME}"
}

goal_help() {
  echo "usage: $0 <goal>

    goal:

    build                    -- Build the image
    test                     -- Test that the image is built correctly
    publish                  -- Publish the image to the hub
    "
  exit 1
}

main() {
  TARGET=${1:-}
  if [ -n "${TARGET}" ] && type -t "goal_$TARGET" &>/dev/null; then
    "goal_$TARGET" "${@:2}"
  else
    goal_help
  fi
}

main "$@"
