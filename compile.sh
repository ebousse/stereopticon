#!/bin/bash

set -e
set -x

REVEALJSVERSION="3.8.0"

STARTFOLDER=${PWD}
REVEALJSTAR="./revealjs.tar.gz"

if [[ ! -d "./reveal.js" ]]; then
    wget "https://github.com/hakimel/reveal.js/tarball/$REVEALJSVERSION" --output-document="$REVEALJSTAR"
    tar -xf "$REVEALJSTAR"
    rm "$REVEALJSTAR"
    REVEALJSEXTRACTED=$(ls -1 | grep hakimel-reveal.js)
    mv "$REVEALJSEXTRACTED" reveal.js
    cd reveal.js
    npm install
fi

cd "${STARTFOLDER}"/reveal.js
ln -fs "${PWD}"/../src/css/theme/source/* ./css/theme/source/ # add our theme to reveal.js
ln -fs "${PWD}"/../src/lib/font/* ./lib/font/                 # add our fonts
npm run build -- css-themes                                   # build all reveal.js themes, including ours
cd "${STARTFOLDER}"
