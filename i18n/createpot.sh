#!/bin/bash

PYTHON=/usr/bin/python
PYFILES=*.py # TODO search for python files
# create the redminehandler.pot file for translation

cd ..

# use xgettext
echo ${PYFILES} | xargs \
  xgettext --package-name "redminehandler" \
    --msgid-bugs-address "mathew.weber@gmail.com" \
    --copyright-hodler "Mathias Weber <mathew.weber@gmail.com>" \
    --from-code ISO-8859-1 --join --sort-by-file --add-comments=i18n \
    --d redminehandler -p i18n -o redminehandler.pot

${PYTHON} i18n/posplit i18n/redminehandler.pot
