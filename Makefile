THEME_VERSION := v0.8.2
THEME := hugo-geekblog
THEMEDIR := themes
.PHONY: doc
doc: doc-assets doc-build
.PHONY: doc-assets
doc-assets:
	cd themes/hugo-geekblog; npm install; npm run build;
.PHONY: doc-build
doc-build:
	hugo