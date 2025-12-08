#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then

    # ----- Validate arguments -----
    if [ $# -ne 1 ]; then
        >&2 echo "Error: wrong argument"
        exit 1
    fi

    secret=$1

    # Check secret is a valid integer between 1 and 100
    if ! [[ $secret =~ ^-?[0-9]+$ ]]; then
        >&2 echo "Error: wrong argument"
        exit 1
    fi

    if [ $secret -lt 1 ] || [ $secret -gt 100 ]; then
        >&2 echo "Error: wrong argument"
        exit 1
    fi

    # ----- Game loop (5 tries) -----
    tries_left=5
    attempt=0

    for i in {1..5}; do
        echo "Enter your guess ($tries_left tries left):"
        read guess

        # Validate guess is a number
        if ! [[ $guess =~ ^-?[0-9]+$ ]]; then
            continue
        fi

        attempt=$((attempt + 1))

        if [ "$guess" -eq "$secret" ]; then
            echo "Congratulations, you found the number in $attempt moves!"
            exit 0
        elif [ "$guess" -gt "$secret" ]; then
            echo "Go down"
        else
            echo "Go up"
        fi

        tries_left=$((tries_left - 1))
    done

    echo "You lost, the number was $secret"
    exit 0

fi
