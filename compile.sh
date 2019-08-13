#!/bin/sh

set -e
set -x

STARTFOLDER=${PWD}

if ! test -d ./reveal.js
then
    git clone -b 3.8.0 --depth 1 https://github.com/hakimel/reveal.js.git
    cd reveal.js
    npm install
fi

cd "${STARTFOLDER}"/reveal.js
ln -fs "${PWD}"/../src/css/theme/source/* ./css/theme/source/ # add our theme to reveal.js
ln -fs "${PWD}"/../src/lib/font/* ./lib/font/ # add our fonts
npm run build -- css-themes # build all reveal.js themes, including ours
cd "${STARTFOLDER}"