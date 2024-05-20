# Find all subdirectories in the current directory
DIRS := $(shell find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)

# Default target
all: stow_all

# Target to stow all directories
stow_all: $(DIRS)

# Target for each directory to run stow
$(DIRS):
	@echo "Stowing $@"
	@stow $@

.PHONY: all stow_all $(DIRS)
