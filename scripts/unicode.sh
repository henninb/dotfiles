#!/bin/sh

fast_chr() {
    __octal=$(printf '%03o' "$1")
    REPLY=$(printf "\\$__octal")
}

unichr() {
    c=$1    # Ordinal of char
    l=0    # Byte ctr
    o=63    # Ceiling
    p=128    # Accum. bits
    s=''    # Output string

    if [ "$c" -lt 128 ]; then
        fast_chr "$c"
        printf "%s" "$REPLY"
        return
    fi

    while [ "$c" -gt "$o" ]; do
        t=$(( (128 | (c & 63)) ))
        fast_chr "$t"
        s="$REPLY$s"
        c=$(( c >> 6 ))
        l=$(( l + 1 ))
        p=$(( p + o + 1 ))
        o=$(( o >> 1 ))
    done

    t=$(( p | c ))
    fast_chr "$t"
    printf "%s" "$REPLY$s"
}

## test harness
i=9472    # Decimal equivalent of 0x2500
while [ "$i" -lt 9728 ]; do    # Decimal equivalent of 0x2600
    unichr "$i"
    i=$(( i + 1 ))
done

# vim: set ft=sh:
