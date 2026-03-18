IRSBS_DIR = ../irsbs
S3_BUCKET = s3://dynamicir

.PHONY: deploy-html deploy-pdf deploy-checklists deploy-all

serve:
	python3 -m http.server 8080

deploy-html:
	cd $(IRSBS_DIR) && make html
	aws s3 sync $(IRSBS_DIR)/images/ $(S3_BUCKET)/book/images/ \
		--exclude "*.pptx" --exclude "*.afdesign" --exclude "*.psd" --exclude "*.drawio"
	aws s3 cp $(IRSBS_DIR)/dynamicir.html $(S3_BUCKET)/book/dynamicir.html \
		--content-type "text/html"

deploy-pdf:
	cd $(IRSBS_DIR) && make pdf
	aws s3 cp $(IRSBS_DIR)/dynamicir.pdf \
		$(S3_BUCKET)/dynamicir-$(shell date +%Y%m%d).pdf

deploy-checklists:
	aws s3 sync checklists/ $(S3_BUCKET)/resources/

deploy-all: deploy-html deploy-pdf deploy-checklists
