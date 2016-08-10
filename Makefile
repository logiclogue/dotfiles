CMDDIR = ls -d */

CURRENTDIR := $(shell pwd)/
HOMEDIR := ~/
DIRS := $(shell $(CMDDIR))


bootstrap: $(DIRS)
	#echo $(CURRENTDIR)
	#echo $(DIRS)

$(DIRS):
	echo $@
	find $@ -exec echo $(CURRENTDIR){} \;

.PHONY: $(DIRS)
