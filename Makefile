.DEFAULT_GOAL := help

repo := ghcr.io/longkey1/go
tags := latest 1.16 1.15 1.14 1.13 1.12 1.11

define build_git_branch
	git checkout master
	git fetch
	git branch -D $(1) || true
	git checkout -b $(1)
	sed -i -e "s@FROM $(repo):latest@FROM $(repo):$(1)@" Dockerfile
	git commit -am "Change base image to $(repo):$(1)" --allow-empty
	git push origin $(1) --force-with-lease
	git checkout master

endef

.PHONY: build
build: ## build all tags
	$(foreach tag,$(tags),$(call build_git_branch,$(tag)))



.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
