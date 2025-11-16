FVM ?= $(shell command -v fvm > /dev/null 2>&1 && echo "fvm")
DART ?= $(FVM) dart
FLUTTER ?= $(FVM) flutter

all:

.PHONY: codegen
codegen:
	$(DART) run build_runner build --delete-conflicting-outputs

.PHONY: lint
lint:
	$(FLUTTER) analyze --no-fatal-infos lib test examples tools flathub
	$(DART) format --output=none --set-exit-if-changed .

.PHONY: test
test:
	$(FLUTTER) test

.PHONY: test-coverage
test-coverage:
	$(FLUTTER) test --coverage

.PHONY: coverage
coverage: test-coverage
	genhtml coverage/lcov.info -o coverage/html
