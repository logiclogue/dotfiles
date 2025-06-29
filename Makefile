# Variables
SRCDIR := src
BUILDDIR := build
NODE := node
BUILD_SCRIPT := build.js

# Find all source files recursively, excluding partials
SRCFILES := $(shell find $(SRCDIR) -type f -not -name "*.swp" -not -path "$(SRCDIR)/_partials/*")
# Find all partial files
PARTIALS := $(shell find $(SRCDIR)/_partials -name "*.hbs" 2>/dev/null || true)
# Transform source paths to build paths
BUILDFILES := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SRCFILES))

# Default target
all: $(BUILDFILES)

# Create build directory structure
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# Individual file transformation rule
$(BUILDDIR)/%: $(SRCDIR)/% config.json $(BUILD_SCRIPT) $(PARTIALS) | $(BUILDDIR)
	@mkdir -p $(dir $@)
	@echo "Processing $<"
	@$(NODE) -e " \
		var Handlebars = require('handlebars'); \
		var fs = require('fs'); \
		var path = require('path'); \
		var config = require('./config.json'); \
		Handlebars.registerHelper('if_not', (condition, options) => { \
			if (!condition) { return options.fn(this); } \
			return options.inverse(this); \
		}); \
		Handlebars.registerHelper('or', () => ( \
			Array.prototype.slice.call(arguments, 0, -1).some(Boolean) \
		)); \
		function registerPartials(dir) { \
			var files = fs.readdirSync(dir); \
			files.forEach(file => { \
				var filePath = path.join(dir, file); \
				var stat = fs.statSync(filePath); \
				if (stat.isDirectory()) { \
					registerPartials(filePath); \
				} else if (file.endsWith('.hbs')) { \
					var partialName = path.relative('$(SRCDIR)', filePath).replace(/\.hbs$$/, ''); \
					var partialContent = fs.readFileSync(filePath, 'utf8'); \
					Handlebars.registerPartial(partialName, partialContent); \
				} \
			}); \
		} \
		if (fs.existsSync('$(SRCDIR)/_partials')) { \
			registerPartials('$(SRCDIR)/_partials'); \
		} \
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
