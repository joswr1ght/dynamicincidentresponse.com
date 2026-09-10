IRSBS_DIR = ../irsbs
S3_BUCKET = s3://dynamicir

.PHONY: all build serve chapters deploy-html deploy-pdf deploy-epub deploy-checklists deploy-all publish

all: build

build: chapters
	cd $(IRSBS_DIR) && make html
	cd $(IRSBS_DIR) && make pdf

serve:
	python3 -m http.server 8080

deploy-html:
	cd $(IRSBS_DIR) && make dynamicir.html
	aws s3 cp $(IRSBS_DIR)/dynamicir.html $(S3_BUCKET)/book/dynamicir.html \
		--content-type "text/html"

deploy-pdf:
	cd $(IRSBS_DIR) && make pdf
	aws s3 cp $(IRSBS_DIR)/dynamicir.pdf \
		$(S3_BUCKET)/dynamicir.pdf

deploy-epub:
	cd $(IRSBS_DIR) && make epub
	aws s3 cp "$(IRSBS_DIR)/Dynamic Incident Response.epub" \
		$(S3_BUCKET)/dynamicir.epub \
		--content-type "application/epub+zip"

deploy-checklists:
	cd $(IRSBS_DIR) && make s3-stepbystep

chapters:
	cd $(IRSBS_DIR) && make webchapters

deploy-all: deploy-html deploy-pdf deploy-epub deploy-checklists

publish: chapters deploy-all
