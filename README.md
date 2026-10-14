# Simple Interest Calculator

This repository contains a simple shell script that calculates simple interest.

## Formula

Simple Interest = (Principal × Rate × Time) / 100

## Usage

Run the script and enter the principal amount, annual rate of interest, and time period when prompted.

```bash
bash simple-interest.sh
```

The principal must be greater than zero. The rate and time may be zero, but all
inputs must be non-negative numbers written with a decimal point when needed.
Invalid or incomplete input exits with a non-zero status and a clear error
message. The result is always displayed with two decimal places.

## Testing

Run the automated shell tests from the repository root:

```bash
bash tests/simple-interest-test.sh
```

## Author

btwamibatman
