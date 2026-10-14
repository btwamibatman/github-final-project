#!/bin/bash

set -o nounset

is_non_negative_number() {
    [[ $1 =~ ^([0-9]+([.][0-9]*)?|[.][0-9]+)$ ]]
}

read_value() {
    local prompt=$1
    local variable_name=$2

    if ! IFS= read -r -p "$prompt" "$variable_name"; then
        echo "Error: input ended before all values were provided." >&2
        exit 1
    fi
}

echo "Simple Interest Calculator"
read_value "Enter the principal amount: " principal
read_value "Enter the annual rate of interest: " rate
read_value "Enter the time period in years: " time

if ! is_non_negative_number "$principal" || ! is_non_negative_number "$rate" || ! is_non_negative_number "$time"; then
    echo "Error: all values must be non-negative numbers using a decimal point." >&2
    exit 1
fi

if ! LC_NUMERIC=C awk -v value="$principal" 'BEGIN { exit !(value > 0) }'; then
    echo "Error: principal amount must be greater than zero." >&2
    exit 1
fi

interest=$(LC_NUMERIC=C awk \
    -v principal="$principal" \
    -v rate="$rate" \
    -v time="$time" \
    'BEGIN { printf "%.2f", (principal * rate * time) / 100 }')

echo "The simple interest is: $interest"
