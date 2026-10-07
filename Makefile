# Book builds and S3 deploys live in ../irsbs (make deploy-all there).
# This Makefile only serves the site locally; publishing is a git push.

.PHONY: serve

# Port 0 lets the OS pick a free port; http.server prints the URL it lands on.
serve:
	python3 -u -m http.server --bind 127.0.0.1 0
