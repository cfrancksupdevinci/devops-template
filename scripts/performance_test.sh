#!/bin/bash
# Script to perform load testing using Apache Benchmark

URL="http://localhost:8080"
CONCURRENT_REQUESTS=10
TOTAL_REQUESTS=100

echo "Starting performance test on $URL..."
ab -n $TOTAL_REQUESTS -c $CONCURRENT_REQUESTS $URL