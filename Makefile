_ != mkdir -p bin

OS   != uname -s
ARCH != uname -m

BUF ?= ${CURDIR}/bin/buf

build: $(shell $(BUF) ls-files) | bin/buf
	$(BUF) build

format fmt: $(shell $(BUF) ls-files) | bin/buf
	$(BUF) format

lint: $(shell $(BUF) ls-files) | bin/buf
	$(BUF) lint

update: | bin/buf
	$(BUF) dep update

bin/buf: .versions/buf
	curl -sSL -o $@ 'https://github.com/bufbuild/buf/releases/download/v$(shell cat $<)/buf-${OS}-${ARCH}'
	@chmod +x $@

.envrc: hack/example.envrc
	cp $< $@ && chmod a=,u+r $@
