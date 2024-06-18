#!/bin/bash
set -e

TAXI_TYPE=$1
YEAR=$2
BASE_URL="https://d37ci6vzurychx.cloudfront.net/trip-data"

# Create the base directory once
BASE_DIR="data/raw/${TAXI_TYPE}/${YEAR}"
mkdir -p ${BASE_DIR}

for MONTH in {1..12}; do
    FMONTH=$(printf "%02d" ${MONTH})
    URL="${BASE_URL}/${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}.parquet"
    
    LOCAL_FILE="${TAXI_TYPE}_tripdata_${YEAR}_${FMONTH}.parquet"
    LOCAL_PATH="${BASE_DIR}/${FMONTH}/${LOCAL_FILE}"

    echo "Downloading ${URL}"
    mkdir -p "$(dirname ${LOCAL_PATH})"
    wget ${URL} -O ${LOCAL_PATH}

    gzip -f ${LOCAL_PATH}
done
