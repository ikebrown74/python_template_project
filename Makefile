# This is the make file to create the packages, documentation,... for the
# application. See the help for the possible targets.

PREFIX=/usr/local
export PREFIX
PYTHON=python
PYFILES:=$(shell find tmppackages -name '*.py')
BINARY_PYFILES:=$(ls bin/)
ASCIIDOCFILES:=$(ls doc/*.asciidoc)
HTMLDOCFILES=$(ASCIIDOCFILES:.asciidoc=.html)
DOCFILES="doc/*.png doc/*.html"

help:
	@echo 'Possible make targets:'
	@echo '  all        - build the app and the documentation'
	@echo '  source     - Create source package'
	@echo '  install    - Install app and doc in respect to PREFIX ($(PREFIX))'
	@echo '  documentation - Create the documentaion from the asciidoc'
	@echo '  clean      - Clean build remobe all files created by other targets'
	@echo '  update-pot - Generate the pot files'

all: documentation source

source:
	${PYTHON} setup.py build
	${PYTHON} setup.py sdist

documentation: ${ASCIIDOCFILES}
	asciidoc doc/tmppackages.asciidoc

install:
	${PYTHON} setup.py ${PURE} install --root="${DESTDIR}/" --prefix="${PREFIX}"

clean:
	-$(PYTHON) setup.py clean --all
	find . \( -name '*.py[cdo]' -o -name '*.so' \) -exec rm -f '{}' ';'
	rm -f MANIFEST MANIFEST.in
	-rm -rf dist
	-rm -rf doc/*.html
	-rm -rf cover
	-rm -rf locale
	-rm -f i18n/tmppackages.pot
	-rm -rf tmppackages/locale

check: tests

tests:
	nosetests --with-coverage --cover-html --cover-erase

update-pot: i18n/tmppackages.pot


i18n/tmppackages.pot:
	echo $(PYFILES) $(BINARY_PYFILES) | xargs \
		xgettext --package-name "tmppackages" \
		--msgid-bugs-address "<mathew.weber@gmail.com>" \
		--copyright-holder "<mathew.weber@gmail.com>" \
		--from-code ISO-8859-1 --sort-by-file --add-comments=i18n: \
		-d tmppackages -p i18n -o tmppackages.pot
	$(PYTHON) i18n/posplit i18n/tmppackages.pot

%.po: i18n/tmppackages.pot
	msgmerge --no-location --update $@ $^

.PHONY: help all source clean install tests update-pot
