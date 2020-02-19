#!/bin/bash

set -e

function downloadAndErase() {
    rm -f "$1"
    echo "Downloading $2…"
    wget -q "$2" --output-document="$1"
}

function downloadIfNotPresent() {
    if [[ ! -f "$1" ]]; then
        downloadAndErase "$1" "$2"
    fi
}

if [[ -f src/css/theme/source/stereopticon.scss ]]; then
    echo "This script must not be run from the stereopticon folder, but from the reveal.js project where you want to install stereopticon!"
    exit 1
fi

if [[ -d reveal.js ]]; then
    cd reveal.js
fi

if [[ ! -f js/reveal.js ]]; then
    echo "This script must be run next to or inside a reveal.js install folder!"
    exit 1
else
    downloadAndErase css/theme/stereopticon.css https://bousse-e.univ-nantes.io/stereopticon/reveal.js/css/theme/stereopticon.css
    downloadIfNotPresent lib/font/yanone-kaffeesatz-latin-400.woff2 https://bousse-e.univ-nantes.io/stereopticon/reveal.js/lib/font/yanone-kaffeesatz-latin-400.woff2
    downloadIfNotPresent lib/font/opensans-latin-300.woff2 https://bousse-e.univ-nantes.io/stereopticon/reveal.js/lib/font/opensans-latin-300.woff2
    downloadIfNotPresent lib/font/opensans-latin-400.woff2 https://bousse-e.univ-nantes.io/stereopticon/reveal.js/lib/font/opensans-latin-400.woff2
    downloadIfNotPresent lib/font/ubuntu-mono-latin-400-normal.woff2 https://bousse-e.univ-nantes.io/stereopticon/reveal.js/lib/font/ubuntu-mono-latin-400-normal.woff2
fi

echo 
echo "stereopticon successfully installed/updated! 🎉" 