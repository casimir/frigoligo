FVM ?= $(shell command -v fvm > /dev/null 2>&1 && echo "fvm")
DART ?= $(FVM) dart
FLUTTER ?= $(FVM) flutter

PIGEON_INPUTS := $(wildcard pigeons/*.dart)
PIGEON_SWIFT_OUTPUTS := $(shell awk -F"'" '/swiftOut:/{print $$2}' $(PIGEON_INPUTS))
SWIFT_FORMAT ?= $(shell command -v swift-format > /dev/null 2>&1 && echo "swift-format format -i")

all:

.PHONY: pigeon $(PIGEON_INPUTS)
pigeon: $(PIGEON_INPUTS)
	$(DART) format pigeons lib/pigeon
	$(SWIFT_FORMAT) $(PIGEON_SWIFT_OUTPUTS)

$(PIGEON_INPUTS):
	$(DART) run pigeon --input $@

.PHONY: codegen
codegen: pigeon
	$(DART) run build_runner build --delete-conflicting-outputs

.PHONY: translations
translations:
	$(FLUTTER) gen-l10n
	$(DART) tools/arb_to_xcstrings.dart
	$(DART) flathub/render_metadata.dart

.PHONY: lint
lint:
	$(FLUTTER) analyze --no-fatal-infos examples flathub lib pigeons test tools
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

.PHONY: vendor-scripts
vendor-scripts:
	$(DART) tools/vendor_scripts.dart

