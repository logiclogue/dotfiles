# Variables
SRCDIR := src
BUILDDIR := build
NODE := node
BUILD_SCRIPT := build.js

# Find all source files recursively
SRCFILES := $(shell find $(SRCDIR) -type f -not -name "*.swp")
# Transform source paths to build paths
BUILDFILES := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SRCFILES))

# Default target
all: $(BUILDFILES)

# Create build directory structure
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# Individual file transformation rule
$(BUILDDIR)/%: $(SRCDIR)/% config.json $(BUILD_SCRIPT) | $(BUILDDIR)
	@mkdir -p $(dir $@)
	@echo "Processing $<"
	@$(NODE) -e " \
		var Handlebars = require('handlebars'); \
		var fs = require('fs'); \
		var config = require('./config.json'); \
		Handlebars.registerHelper('if_not', (condition, options) => { \
			if (!condition) { return options.fn(this); } \
			return options.inverse(this); \
		}); \
		Handlebars.registerHelper('or', () => ( \
			Array.prototype.slice.call(arguments, 0, -1).some(Boolean) \
		)); \
		var file = fs.readFileSync('$<'); \
		var template = Handlebars.compile(file.toString()); \
		var compiledFile = template(config); \
		fs.writeFileSync('$@', compiledFile); \
	"

# Clean build directory
clean:
	rm -rf $(BUILDDIR)

# Show what files would be built
list:
	@echo "Source files:"
	@echo $(SRCFILES) | tr ' ' '\n'
	@echo ""
	@echo "Build targets:"
	@echo $(BUILDFILES) | tr ' ' '\n'

# Force rebuild of all files
rebuild: clean all

.PHONY: all clean list rebuild
