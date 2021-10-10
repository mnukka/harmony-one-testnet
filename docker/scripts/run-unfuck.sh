#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
harmony_dir="$(go env GOPATH)/src/github.com/harmony-one/harmony"
localnet_config=$(realpath "$DIR/../configs/localnet_deploy.config")

function stop() {
  if [ "$KEEP" == "true" ]; then
    tail -f /dev/null
  fi
  kill_localnet
}

function kill_localnet() {
  pushd "$(pwd)"
  cd "$harmony_dir" && bash ./test/kill_node.sh
  popd
}

function setup() {
  if [ ! -d "$harmony_dir" ]; then
    echo "Test setup FAILED: Missing harmony directory at $harmony_dir"
    exit 1
  fi
  if [ ! -f "$localnet_config" ]; then
    echo "Test setup FAILED: Missing localnet deploy config at $localnet_config"
    exit 1
  fi
  kill_localnet
  error=0  # reset error/exit code
}

function build_and_start_localnet() {
  local localnet_log="$harmony_dir/localnet_deploy.log"
  rm -rf "$harmony_dir/tmp_log*"
  rm -rf "$harmony_dir/.dht*"
  rm -f "$localnet_log"
  rm -f "$harmony_dir/*.rlp"
  pushd "$(pwd)"
  cd "$harmony_dir"
  if [ "$BUILD" == "true" ]; then
    # Dynamic for faster build iterations
    bash ./scripts/go_executable_build.sh -S
    BUILD=False
  fi
  bash ./test/deploy.sh -e -B -D 60000 "$localnet_config" 2>&1 | tee "$localnet_log"
  popd
}

function rpc_tests() {
  echo -e "\n=== \e[38;5;0;48;5;255mSTARTING UNFUCKED HARMONY GANACHE\e[0m ===\n"
  build_and_start_localnet || exit 1 &
  sleep 20
  wait_for_localnet_boot 100 # Timeout at ~300 seconds

  echo -e "\n=== \e[38;5;0;48;5;255mEVERYTHING IS GUCI - HARMONY IS NOW RUNNING\e[0m ===\n"
  echo -e "\n=== \e[38;5;0;48;5;255mTIME TO POWER SOME LAMBOS\e[0m ===\n"

  hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1ax072u4nllu5z2f965dasqluwassy5kvjc36zr --to-shard 0 --amount 100
  hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1ynkr6c3jc724htljta4hm9wvuxpgxyulf3mg2j --to-shard 0 --amount 1000
  # uncomment these if you need more accounts with ONE - these are commented with start up speed kept in mind
  #hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1rsup4xsrh9k6v6pjr2jmutpj8hnrcg22dxvgpt --to-shard 0 --amount 100
  #hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1705zuq02my9xgrwce8a020yve9fgj83m56wxpq --to-shard 0 --amount 100
  #hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1u9fytdmjn24a8atfpltassunfq9jducedmxam2 --to-shard 0 --amount 100
  #hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1f6373nd4ymxgrszhz2mluakghgnhm7g8ltq2w8 --to-shard 0 --amount 100
  #hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1nuy5t8qmz0ksklal9fa53urz3jc2yzwdp6xaks --to-shard 0 --amount 100
  #hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one1tlj2520ulz7as4ynyj7rhftlwd8wjfhpnxh8l6 --to-shard 0 --amount 100
  #hmy transfer --from one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 --from-shard 0 --to one12rzgrlwrquf97kc8ttx9udcsj4mw0d9an4c7a9 --to-shard 0 --amount 100

  echo -e "\n=== \e[38;5;0;48;5;255m one155jp2y76nazx8uw5sa94fr0m4s5aj8e5xm6fu3 \e[0m ===\n"
  echo -e "\n 1kk+ ONE: 1f84c95ac16e6a50f08d44c7bde7aff8742212fda6e4321fde48bf83bef266dc \n"

  echo -e "\n=== \e[38;5;0;48;5;255m one1ax072u4nllu5z2f965dasqluwassy5kvjc36zr \e[0m ===\n"
  echo -e "\n 100 ONE: 59f46b7addacb231e75932d384c5c75d5e9a84920609b5d27a57922244efbf90 \n"

  echo -e "\n=== \e[38;5;0;48;5;255m one1ynkr6c3jc724htljta4hm9wvuxpgxyulf3mg2j \e[0m ===\n"
  echo -e "\n 1000 ONE: d8ee0370d50f5d32c50704f4a0d01f027ab048d9cdb2f137b7ae852d8590d63f \n"
  echo -e "\n eof \n"
}

function wait_for_localnet_boot() {
  timeout=70
  if [ -n "$1" ]; then
    timeout=$1
  fi
  i=0
  until curl --silent --location --request POST "localhost:9500" \
    --header "Content-Type: application/json" \
    --data '{"jsonrpc":"2.0","method":"net_version","params":[],"id":1}' >/dev/null; do
    echo "Trying to connect to localnet..."
    if ((i > timeout)); then
      echo "TIMEOUT REACHED"
      exit 1
    fi
    sleep 3
    i=$((i + 1))
  done

  valid=false
  until $valid; do
    result=$(curl --silent --location --request POST "localhost:9500" \
      --header "Content-Type: application/json" \
      --data '{"jsonrpc":"2.0","method":"hmy_blockNumber","params":[],"id":1}' | jq '.result')
    if [ "$result" = "\"0x0\"" ]; then
      echo "Waiting for localnet to boot..."
      if ((i > timeout)); then
        echo "TIMEOUT REACHED"
        exit 1
      fi
      sleep 3
      i=$((i + 1))
    else
      valid=true
    fi
  done

  sleep 15  # Give some slack to ensure localnet is booted...
  echo "Localnet booted."
}

function wait_for_epoch() {
  wait_for_localnet_boot "$2"
  cur_epoch=0
  echo "Waiting for epoch $1..."
  until ((cur_epoch >= "$1")); do
    cur_epoch=$(curl --silent --location --request POST "localhost:9500" \
    --header "Content-Type: application/json" \
    --data '{"jsonrpc":"2.0","method":"hmyv2_latestHeader","params":[],"id":1}' | jq .result.epoch)
    if ((i > timeout)); then
      echo "TIMEOUT REACHED"
      exit 1
    fi
    sleep 3
    i=$((i + 1))
  done
}

trap stop SIGINT SIGTERM EXIT

BUILD=true
KEEP=false
GO=true
RPC=true
ROSETTA=true

while getopts "Bkgnr" option; do
  case ${option} in
  B) BUILD=false ;;
  k) KEEP=true ;;
  g) RPC=false
     ROSETTA=false
  ;;
  n)
    GO=false
    ROSETTA=false
  ;;
  r)
    GO=false
    RPC=false
  ;;
  *) echo "
Integration tester for localnet

Option:      Help:
-B           Do NOT build binray before testing
-k           Keep localnet running after Node API tests are finished
-g           ONLY run go tests & checks
-n           ONLY run the RPC tests
-r           ONLY run the rosetta API tests
"
  exit 0
  ;;
  esac
done

setup

if [ "$RPC" == "true" ]; then
  rpc_tests
fi


exit "$error"
