SHELL=/bin/zsh
PRE_COMMIT_DIR=.git-template
MAKEFILE_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

KNOWN_TARGETS := init \
	init-upgrade \
	plan \
	plan-fast \

.PHONY: $(KNOWN_TARGETS)

ARGS := $(filter-out $(KNOWN_TARGETS), $(MAKECMDGOALS))

init:
	terramate script run \
		--tags "${ARGS}" \
		--parallel 1 \
		--continue-on-error \
		--disable-safeguards=git \
		--include-output-dependencies \
		-- \
		init

init-upgrade:
	terramate script run \
		--tags "${ARGS}" \
		--parallel 1 \
		--continue-on-error \
		--disable-safeguards=git \
		--include-output-dependencies \
		-- \
		init upgrade

plan:
	terramate script run \
		--tags "${ARGS}" \
		--parallel 1 \
		--continue-on-error \
		--disable-safeguards=git \
		--include-output-dependencies \
		-- \
		plan

# Catch-all target to prevent errors when extra words are passed.
%:
	@:
