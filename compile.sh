#!/bin/bash

set -e
set -x

REVEALJSVERSION="4.5.0"

STARTFOLDER=${PWD}
REVEALJSTAR="./revealjs.tar.gz"

if [[ ! -d "./reveal.js" ]]; then
    wget "https://github.com/hakimel/reveal.js/tarball/$REVEALJSVERSION" --output-document="$REVEALJSTAR"
    tar -xf "$REVEALJSTAR"
    rm "$REVEALJSTAR"
    REVEALJSEXTRACTED=$(ls -1 | grep hakimel-reveal.js)
    mv "$REVEALJSEXTRACTED" reveal.js

    if [[ -d "./node_modules" ]]; then
        mv node_modules reveal.js
    else
        cd reveal.js
        npm install
        npm install gulp-cli
    fi

fi

cd "${STARTFOLDER}"/reveal.js
ln -fs "${PWD}"/../src/css/theme/source/* ./css/theme/source/ # add our theme to reveal.js
ln -fs "${PWD}"/../src/lib/font/* ./dist/theme/fonts          # add our fonts
npm run build -- css-themes                                   # build all reveal.js themes, including ours
cd "${STARTFOLDER}"
mv reveal.js/node_modules .                                   # remove node_modules from reveal (to not overload gitlab)
