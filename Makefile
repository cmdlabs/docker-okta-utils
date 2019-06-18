IMAGE_NAME ?= cmdlabs/okta-utils

RELEASE_VERSION = 1.0.1
BUILD_VERSION ?= testing

ifdef CI_COMMIT_REF_NAME
	BUILD_VERSION=$(CI_COMMIT_REF_NAME)
endif

dockerBuild:
	docker build --pull -t $(IMAGE_NAME):$(BUILD_VERSION) .
.PHONY: dockerBuild

dockerTest:
	docker run --rm --entrypoint=oktashell $(IMAGE_NAME):$(BUILD_VERSION) --help
	docker run --rm --entrypoint=AssumeRole $(IMAGE_NAME):$(BUILD_VERSION) --help
	@echo "All tests completed successfully" 
.PHONY: dockerTest

dockerPush:
	docker push $(IMAGE_NAME):$(BUILD_VERSION)
.PHONY: dockerPush

dockerTagLatest:
	docker pull $(IMAGE_NAME):$(BUILD_VERSION)
	docker tag $(IMAGE_NAME):$(BUILD_VERSION) $(IMAGE_NAME):latest
	docker push $(IMAGE_NAME):latest
.PHONY: dockerTagLatest

tag:
	git tag $(RELEASE_VERSION)
	git push origin $(RELEASE_VERSION)
.PHONY: tag
