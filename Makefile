include makefiles/variables.Makefile

PHONY: release
release:
	git add ./makefiles/variables.Makefile
	git commit -m "Released $(PKG_NAME) $(PKG_VERSION) via make release"
	git tag $(PKG_VERSION)
	git push --atomic origin main $(PKG_VERSION)

luci-app-nauta.ipk:
	docker run --rm -v $$(pwd):/home/build/$(PKG_NAME) openwrtorg/sdk bash -c ../$(PKG_NAME)/build.sh
