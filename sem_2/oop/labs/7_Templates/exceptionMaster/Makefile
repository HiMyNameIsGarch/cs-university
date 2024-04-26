# Compiler flags
CXX = clang++
CXXFLAGS = -std=c++20 -Wall -Wextra -I$(INCLUDE_DIR) -Werror -Wpedantic -g

# Directories
SRC_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build
DEBUG_DIR = debug

# Files and include directories
SRC_FILES := $(shell find $(SRC_DIR) -type f -name '*.cpp')
H_FILES := $(shell find $(INCLUDE_DIR) -type f -name '*.h')
INCLUDE_DIRS := $(shell find $(INCLUDE_DIR) -type d)

MAIN := ./app.cpp
EXECUTABLE = $(BUILD_DIR)/app

.PHONY: all clean debug run

all: clean $(EXECUTABLE) run

# Build the executable
$(EXECUTABLE): $(SRC_FILES) $(H_FILES)
	@mkdir -p $(BUILD_DIR) # Make sure the build directory exists
	@echo "Building executable..."
	$(CXX) $(CXXFLAGS) -o $@ $^ $(MAIN) && echo "Executable built successfully!" || echo "Failed to build executable!"

# Debug the executable
debug: $(EXECUTABLE)
	@mkdir -p $(DEBUG_DIR) # Make sure the debug directory exists
	@valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=$(DEBUG_DIR)/valgrind_output.txt ./$(EXECUTABLE)
	@echo "Valgrind output saved to $(DEBUG_DIR)/valgrind_output.txt"
	@cat $(DEBUG_DIR)/valgrind_output.txt

# Run the executable
run: $(EXECUTABLE)
	@./$(EXECUTABLE)

# Clean the build and debug directories
clean:
	rm -rf $(BUILD_DIR)/* $(DEBUG_DIR)/*
