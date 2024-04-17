#!/bin/bash

# Number of processes to run concurrently
num_processes=10

# Number of IDs to generate per process
num_ids_per_process=100

# Function to generate IDs using genid
generate_ids() {
  for ((i=1; i<=num_ids_per_process; i++)); do
    ./genid.sh
  done
}

# Run genid concurrently using multiple processes
for ((i=1; i<=num_processes; i++)); do
  generate_ids &
done

# Wait for all processes to finish
wait

# Collect the generated IDs and sort them
generated_ids=$(./genid.sh | sort -n)

# Check for missing or duplicate IDs
expected_ids=$(seq -f "%05g" 1 $((num_processes * num_ids_per_process)))
if [[ "$generated_ids" == "$expected_ids" ]]; then
  echo "All IDs generated successfully with no missing or duplicate IDs."
else
  echo "Error: Missing or duplicate IDs detected."
fi
