
include variables.Makefile

PHONY: release
release:
	git add ./variables.Makefile
	git commit -m "Released $(PKG_NAME) $(PKG_VERSION) via make release"
	git tag $(PKG_VERSION)
	git push --atomic origin main $(PKG_VERSION)