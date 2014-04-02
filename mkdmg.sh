#!/bin/bash

src=$1
outfile="$src".img

if [[ ! -n $src ]]; then
    echo "Usage: $0 <disk.iso>"
    exit 1
fi

echo "Converting $src to $outfile..."
if [[ ! -f "$outfile" ]]; then
    hdiutil convert -format UDRW -o "$outfile" "$src"
fi
