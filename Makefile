# ------------------------------------------------
#  # Generic Makefile
#
# Author: yanick.rochon@gmail.com & github.com/MarcoBomfim
# Date  : 2011-08-10
# Source: https://stackoverflow.com/questions/7004702/how-can-i-create-a-makefile-for-c-projects-with-src-obj-and-bin-subdirectories
#
# Changelog :
#   2010-11-05 - first version
#   2011-08-10 - added structure : sources, objects, binaries
#                thanks to http://stackoverflow.com/users/128940/beta
#   2017-04-24 - changed order of linker params
#   2021-04-13 - added some color to the echoes, and some minor refactor (Marco)
#   2021-04-13 - added run step (Marco)
# ------------------------------------------------

# project name (generate executable with this name)
TARGET   = main

# Set up colors
RED    = \033[1;31m
GREEN  = \033[1;32m
YELLOW = \033[1;33m
BLUE   = \033[1;34m
BG     = \033[1;3m
NC     = \033[1;0m

# compiling flags here
CC       = gcc
CFLAGS   = -std=c99 -Wall -Werror=implicit-function-declaration -I.

# linking flags here
LINKER   = gcc
LFLAGS   = -Wall -I. -lm

# change these to proper directories where each file should be
SOURCE_DIR   = src
OBJECT_DIR   = obj
BINARY_DIR   = bin

SOURCE_FILES  := $(wildcard $(SOURCE_DIR)/*.c)
HEADER_FILES := $(wildcard $(SOURCE_DIR)/*.h)
OBJECT_FILES  := $(SOURCE_FILES:$(SOURCE_DIR)/%.c=$(OBJECT_DIR)/%.o)
rm       = rm -f


$(BINARY_DIR)/$(TARGET): $(OBJECT_FILES)
	@echo "$(BLUE)Linking...$(BG)"
	@$(LINKER) $(OBJECT_FILES) $(LFLAGS) -o $@
	@echo "$(GREEN)Linking complete!\n"

$(OBJECT_FILES): $(OBJECT_DIR)/%.o : $(SOURCE_DIR)/%.c
	@echo "$(BLUE)Compiling...$(BG)"
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo "$(GREEN)Compiled "$<" successfully!\n"

.PHONY: clean
clean:
	@$(rm) $(OBJECT_FILES)
	@echo "$(RED)Cleanup complete!\n"

.PHONY: remove
remove: clean
	@$(rm) $(BINARY_DIR)/$(TARGET)
	@echo "$(RED)Executable removed!\n"

.PHONY: run
run:
	@echo "$(YELLOW)Running $(BINARY_DIR)/$(TARGET)$(NC)\n"
	./$(BINARY_DIR)/$(TARGET)
