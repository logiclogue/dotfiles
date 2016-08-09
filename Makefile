CMDDIR = ls -d */
CMDFILES = 

CURRENTDIR := $(shell pwd)
HOMEDIR := ~/
DIRS := $(shell $(CMDDIR))


bootstrap: $(DIRS)
	echo $(CURRENTDIR)
	echo $(DIRS)

$(DIRS):
	ls $@*

.PHONY: $(DIRS)
