
.PHONY: build
build:
	ONLY_BUILD=true ./scripts/build_and_push.sh

.PHONY: build-and-push
build-and-push:
	./scripts/build_and_push.sh
