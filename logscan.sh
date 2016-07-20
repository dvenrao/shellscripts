#!/bin/bash

secs=60   # Set interval (duration) in seconds.
endTime=$(( $(date +%s) + secs )) # Calculate end time.

SECONDS=0
while [ "$(date +%s)" -lt $endTime ]; do
SUCCESS=$(docker logs jira-upgrade-tst 2>&1 | grep -c "1Latest index date\|1Heap memory")

if [ "$SUCCESS" == 2 ]; then
  exit 0
fi

timeout=$(( endTime - $(date +%s) ))
echo "search again for success message $timeout"
sleep 5
done

exit 1
