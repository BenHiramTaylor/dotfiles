# Read ignore patterns from .stow-local-ignore and format them for grep
IGNORE_PATTERNS := $(shell cat .stow-local-ignore | sed 's/^/-e /' | tr '\n' ' ')

# Find all subdirectories in the current directory and filter out ignored ones
DIRS := $(shell find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | grep -v $(IGNORE_PATTERNS))

# Default target
all: stow_all

# Target to stow all directories
stow_all: $(DIRS)

# Target for each directory to run stow
$(DIRS):
	@echo "Stowing $@"
	@stow $@

.PHONY: all stow_all $(DIRS)
