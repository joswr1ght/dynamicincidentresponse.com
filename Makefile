# Book builds and S3 deploys live in ../irsbs (make deploy-all there).
# This Makefile only serves the site locally; publishing is a git push.

.PHONY: serve

serve:
	python3 -m http.server 8080
