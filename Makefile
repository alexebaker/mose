build:
	go get -u github.com/gobuffalo/packr/v2/packr2
	export GO111MODULE=on
	go get
	go build
	packr2 clean
	packr2 build
	mkdir -p payloads

setup-linter: ## Install all the build and lint dependencies
	gometalinter --install

fmt: ## gofmt and goimports all go files
	find . -name '*.go' -not -wholename './vendor/*' | while read -r file; do gofmt -w -s "$$file"; goimports -w "$$file"; done

lint: ## Run all the linters
	gometalinter --vendor --disable-all \
		--enable=deadcode \
		--enable=ineffassign \
		--enable=staticcheck \
		--enable=gofmt \
		--enable=goimports \
		--enable=dupl \
		--enable=misspell \
		--enable=errcheck \
		--enable=vet \
		--enable=vetshadow \
		--deadline=10m \
		./...
	markdownfmt -w README.md