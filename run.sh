#!/bin/bash
# run.sh - Automates build, test, and coverage steps for the C++ test generator project

# Exit on any error
set -e

# === Step 1: Clean previous build ===
echo "[INFO] Cleaning previous build..."
rm -rf build

# === Step 2: Configure the project ===
echo "[INFO] Configuring project with CMake..."
cmake -DCMAKE_CXX_COMPILER=g++ -DCMAKE_CXX_FLAGS="--coverage" -B build

# === Step 3: Build the project ===
echo "[INFO] Building project..."
cd build
make

# === Step 4: Run the tests ===
echo "[INFO] Running tests..."
./main_test

# === Step 5: Generate code coverage report ===
echo "[INFO] Generating code coverage report..."
gcovr -r .. --exclude '.*_deps/.*' --exclude '.*CMakeFiles.*' > coverage.txt
gcovr -r .. --exclude '.*_deps/.*' --exclude '.*CMakeFiles.*' --html --html-details -o coverage.html

# === Step 6: Open the HTML report (optional if you have xdg-open) ===
if command -v xdg-open &> /dev/null; then
    echo "[INFO] Opening HTML report..."
    xdg-open coverage.html
else
    echo "[INFO] Report generated: build/coverage.html (open manually in browser)"
fi

cd ..
echo "[SUCCESS] All tasks completed."
