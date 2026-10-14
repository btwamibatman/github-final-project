#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

script_path=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/simple-interest.sh
tests_run=0

assert_success() {
    local input=$1
    local expected=$2
    local output

    output=$(printf '%b' "$input" | bash "$script_path" 2>&1)
    [[ $output == *"$expected"* ]] || {
        echo "Expected successful output to contain: $expected" >&2
        echo "Actual output: $output" >&2
        exit 1
    }
    tests_run=$((tests_run + 1))
}

assert_failure() {
    local input=$1
    local expected=$2
    local output
    local status

    set +o errexit
    output=$(printf '%b' "$input" | bash "$script_path" 2>&1)
    status=$?
    set -o errexit

    [[ $status -ne 0 ]] || {
        echo "Expected command to fail for input: $input" >&2
        exit 1
    }
    [[ $output == *"$expected"* ]] || {
        echo "Expected error output to contain: $expected" >&2
        echo "Actual output: $output" >&2
        exit 1
    }
    tests_run=$((tests_run + 1))
}

assert_success '1000\n5\n2\n' 'The simple interest is: 100.00'
assert_success '250.50\n4.25\n1.5\n' 'The simple interest is: 15.97'
assert_success '100\n0\n3\n' 'The simple interest is: 0.00'
assert_failure 'not-a-number\n5\n2\n' 'all values must be non-negative numbers'
assert_failure '-100\n5\n2\n' 'all values must be non-negative numbers'
assert_failure '0\n5\n2\n' 'principal amount must be greater than zero'
assert_failure '100\n5\n' 'input ended before all values were provided'

echo "All $tests_run tests passed."
