PRJ_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/

BIN_DIR := $(PRJ_DIR)node_modules/.bin/
<<<<<<< HEAD
BOWER = $(BIN_DIR)bower
JSHINT = $(BIN_DIR)jshint
JSCS = $(BIN_DIR)jscs
BORSCHIK = $(BIN_DIR)borschik
NPM = /usr/bin/npm

DIRS_FOR_LINT := $(PRJ_DIR)js/index.js

all: test build

.PHONY: test
test: jshint jscs

.PHONY: jshint
jshint: $(JSHINT)
	$(JSHINT) $(DIRS_FOR_LINT)

.PHONY: jscs
jscs: $(JSCS)
	$(JSCS) $(DIRS_FOR_LINT)

.PHONY: libs
libs: $(BOWER)
	$(BOWER) install

.PHONY: build
build: $(BORSCHIK) libs
	$(BORSCHIK) -i js/index.js -o js/index.min.js -t js -m yes
	$(BORSCHIK) -i css/index.css -o css/index.min.css -t css -m yes -f no

$(BOWER) $(BORSCHIK) $(JSHINT) $(JSCS):
	npm install
=======
JSHINT := $(BIN_DIR)jshint
JSCS := $(BIN_DIR)jscs
NODEUNIT := $(BIN_DIR)nodeunit
ISTANBUL := $(BIN_DIR)istanbul
BORSCHIK := $(BIN_DIR)borschik
MOCHA := $(BIN_DIR)mocha
_MOCHA := $(BIN_DIR)_mocha
KARMA := $(PRJ_DIR)node_modules/karma/bin/karma

FILES_FOR_LINT := $(PRJ_DIR)lib $(PRJ_DIR)test/*.js $(PRJ_DIR)karma.conf.js

all: build test hook

.PHONY: test
test: codestyle unittests

.PHONY: codestyle
codestyle: jscs jshint

.PHONY: unittests
unittests: nodejsunittests browsersunittests

.PHONY: unittests_in_nodejs
nodejsunittests: $(MOCHA)
	$(MOCHA) -u bdd -R spec -r chai $(PRJ_DIR)test/nodejs $(PRJ_DIR)test

.PHONY: unittests_in_browsers
browsersunittests: $(KARMA) build
	$(KARMA) start $(PRJ_DIR)karma.conf.js --single-run

.PHONY: jshint
jshint: $(JSHINT)
	$(JSHINT) $(FILES_FOR_LINT)

.PHONY: jscs
jscs: $(JSCS)
	$(JSCS) $(FILES_FOR_LINT)

.PHONY: coverage
coverage: $(ISTANBUL) $(_MOCHA)
	$(ISTANBUL) cover $(_MOCHA) -- -u bdd $(PRJ_DIR)test/nodejs $(PRJ_DIR)test

$(JSHINT) $(MOCHA) $(_MOCHA) $(ISTANBUL) $(JSCS) $(BORSCHIK) $(KARMA):
	npm install

.PHONY: hook
hook: $(PRJ_DIR).git/hooks/pre-commit
$(PRJ_DIR).git/hooks/pre-commit: $(PRJ_DIR)pre-commit
	cp $< $@

.PHONY: build
build: $(BORSCHIK)
	$(BORSCHIK) -i $(PRJ_DIR)dist/susanin.tmp.js -o $(PRJ_DIR)dist/susanin.js -m no
	$(BORSCHIK) -i $(PRJ_DIR)dist/susanin.tmp.js -o $(PRJ_DIR)dist/susanin.min.js
>>>>>>> refs/remotes/nodules/master
