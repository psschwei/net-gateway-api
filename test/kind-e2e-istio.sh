#!/usr/bin/env bash

# Copyright 2021 The Knative Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script runs the end-to-end tests against net-gateway-api built from source.
# It is started by prow for each PR. For convenience, it can also be executed manually:
  # If you already have a Knative cluster setup and kubectl pointing
  # to it, call this script with the --run-tests arguments and it will use
  # the cluster and run the tests.

  # Calling this script without arguments will create a new cluster in
  # project $PROJECT_ID, start knative in it, run the tests and delete the
  # cluster.

set -eo pipefail

source "$(dirname $0)"/e2e-common.sh
source "$(dirname $0)"/e2e-library-deployments.sh
source "$(dirname $0)"/e2e-library.sh

test_setup
deploy_gateway_for istio kind
wait_for_pods
kind_e2e_istio
