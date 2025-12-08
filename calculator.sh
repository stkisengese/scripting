#!/bin/bash

# ---------- Error handling ----------
if [ $# -ne 3 ]; then
    >&2 echo "Error: expect 3 arguments"
    exit 1
fi

left=$1
op=$2
right=$3

# ---------- Validate numbers ----------
# regex: optional leading -, then digits
if ! [[ $left =~ ^-?[0-9]+$ ]] || ! [[ $right =~ ^-?[0-9]+$ ]]; then
    >&2 echo "Error: invalid number"
    exit 4
fi

# ---------- Functions ----------
do_add() {
    echo $(($1 + $2))
}

do_sub() {
    echo $(($1 - $2))
}

do_mult() {
    echo $(($1 * $2))
}

do_divide() {
    # division by zero check happens before this function is called
    echo $(($1 / $2))
}

# ---------- operator validation ----------
case "$op" in
    "+")
        do_add "$left" "$right"
        ;;
    "-")
        do_sub "$left" "$right"
        ;;
    "*")
        do_mult "$left" "$right"
        ;;
    "/")
        if [ "$right" -eq 0 ]; then
            >&2 echo "Error: division by 0"
            exit 2
        fi
        do_divide "$left" "$right"
        ;;
    *)
        >&2 echo "Error: invalid operator"
        exit 3
        ;;
esac
