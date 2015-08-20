#!/bin/bash

echo "Starting server..."

close() {
    echo "Shutting down..."
    kill %1
    sleep 1
    echo "All done!"
}

trap close INT

redis-server &
rails s
