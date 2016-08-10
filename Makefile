CMDDIR = ls -d */

CURRENTDIR := $(shell pwd)/
HOMEDIR := ~/
DIRS := $(shell $(CMDDIR))


bootstrap: $(DIRS)

$(DIRS):
	echo $@
	find $@ -maxdepth 1 -not -path "vim/" -exec echo $(CURRENTDIR)$@{} $(HOMEDIR){} \;

.PHONY: $(DIRS)
