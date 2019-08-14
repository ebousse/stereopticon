#!/bin/sh

set -e
set -x

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

cd "$SCRIPTPATH"

if test ! -f ./.bundle/.bin/asciidoctor-revealjs; then
    bundle config --local github.https true
    bundle --path=.bundle/gems --binstubs=.bundle/.bin
fi

if test ! -d ../reveal.js; then
    cd ..
    bash ./compile.sh
fi

cd "$SCRIPTPATH"

ln -sf ../reveal.js

./.bundle/.bin/asciidoctor-revealjs index.adoc
